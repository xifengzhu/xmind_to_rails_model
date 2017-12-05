require "xmind_to_rails_model/version"

require 'json'
require 'active_support/core_ext/hash'

module XmindToRailsModel

  class Service
    attr_reader :freemind_file, :model_jsons

    def initialize(args)
      @freemind_file = args
      @current_model_json = init_model_data_struct
      @model_jsons = []
    end

    def init_model_data_struct
      {
        name: '',
        attributes: []
      }
    end

    def xml_to_json
      file = File.open(@freemind_file, "r")
      xmind_json = Hash.from_xml(file.read)
      clean_model_json(xmind_json["map"]['node']['node'])
    end

    def clean_model_json(root)
      root.map do |chidren_node|
        @current_model_json[:name] = chidren_node['TEXT']
        if chidren_node['node'].present?
          chidren_node['node'].each do |node|
            node_name = node['TEXT']
            if node_name == 'attrs'
              model_attributes(node)
            elsif node_name == 'associations'
              model_association_attributes(node)
            elsif node_name == 'STI'
              @current_model_json[:attributes] << {attr_name: "type", type: 'string'}
            else
              puts "暂时不支持 associations #{node_name}"
            end
          end
        end
        @current_model_json[:attributes].flatten(2)
        @model_jsons << @current_model_json
        @current_model_json = init_model_data_struct
      end
    end

    # 获取attrs下面节点的所有属性
    def model_attributes(model_node)
      @current_model_json[:attributes] << [model_node['node']].flatten.map do |node|
        attr_type =  if node['node'].present?
          # 当节点为数组时候，表示该数据类型为 enum
          # 当没有填写数据类型为 string
          if node['node'].is_a? Array
            "integer"
          else
            node['node']['TEXT']
          end
        else
          "string"
        end
        {attr_name: node['TEXT'], type: attr_type}
      end
    end

    # 添加 association 中的 belongs_to 跟 polymorphic 的属性
    def model_association_attributes(model_node)
      [model_node['node']].flatten.map do |node|
        if node["TEXT"] == 'belongs_to'
          # 给belongs_to 添加字段跟 index
          # 由于不能确定建表的顺序，不能使用 belongs_to/references 方式建立关联，否则数据库检查FOREIGN KEY时可能会报错
          [node['node']].flatten.map do |chidren_node|
            @current_model_json[:attributes] << {attr_name: "#{chidren_node['TEXT']}_id", type: 'integer:index'}
            if chidren_node['node'] && chidren_node['node']['TEXT'] == 'polymorphic'
              add_polymorphic_attr_to_attributes(chidren_node)
            end
          end
        end
      end
    end

    # 将 polymorphic 中 _type 加入 attributes
    def add_polymorphic_attr_to_attributes(polymorphic_node)
      polymorphic_node['node']['node'].each do |chidren_node|
        if chidren_node['TEXT'].include?("_type")
          @current_model_json[:attributes] << {attr_name: chidren_node['TEXT'], type: 'string'}
        end
      end
      puts "需要在 migration 中为 #{polymorphic_node['node']['node'].collect{|ar| ar['TEXT']}.join(' ')} 手动添加联合索引"
    end

    def generate_model_script(model_json)
      script = "rails g model #{model_json[:name].strip()}"
      model_json[:attributes].flatten.compact.each do |attribute|
        script += " #{attribute[:attr_name].strip()}:#{attribute[:type].strip()} "
      end if model_json[:attributes]
      script
    end


    def transform_freemind_to_rails_model
      xml_to_json
      @model_jsons.map do |model|
        script = generate_model_script(model)
        system script
      end
    end
  end
end

