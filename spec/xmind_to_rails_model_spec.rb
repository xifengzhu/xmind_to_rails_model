require "spec_helper"

describe XmindToRailsModel do
  it "has a version number" do
    expect(XmindToRailsModel::VERSION).not_to be nil
  end

  it "translate from Project-freemind.mm to correct model number" do
    file = File.expand_path('../spec/Project-freemind.mm', File.dirname(__FILE__))
    service = XmindToRailsModel::Service.new(file)
    service.xml_to_json
    expect(service.model_jsons.count).to eq(2)
  end
end
