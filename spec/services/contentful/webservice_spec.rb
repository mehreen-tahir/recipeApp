require 'rails_helper'

describe "Contentful WebService" do
  subject { Contentful::Webservice }

  describe "#public methods" do
    it "validates client method" do
      expect(subject.public_methods.include?(:client)).to eq true
    end
  end

  describe "#client" do
    context "connection successfull" do
      it "returns client object with configurations" do
        client = subject.client
        expect(client.configuration.present?).to eq true
      end
    end

    context "connection unsuccessfull" do
      before do
        ENV['SPACE_KEY'] = 'random'
      end

      it "returns contentful not found error" do
        expect(subject.client).to eql "Contentful::NotFound"
      end
    end
  end
end