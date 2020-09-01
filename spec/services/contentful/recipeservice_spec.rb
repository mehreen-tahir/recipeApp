require 'rails_helper'

describe "Contentful Recipe Service" do
  subject { Contentful::RecipeService.new }

  describe "#public methods" do
    it "validates perform method" do
      expect(subject.public_methods.include?(:perform)).to eq true
    end

    it "returns false for private methods" do
      expect(subject.public_methods.include?(:recipe_details)).to eq false
      expect(subject.public_methods.include?(:recipes_list)).to eq false
    end
  end

  describe "#perform recipes_list" do
    context "request is valid" do
      it "returns correct response for recipes list" do
        response = subject.perform(:recipes_list)

        expect(response.keys).to match_array [:data, :status]
        expect(response[:status]).to eq(200)
      end

      it "returns correct fields for recipes list" do
        response = subject.perform(:recipes_list)
        expect(response[:data].first.keys).to match_array [:title, :id, :image]
      end
    end

    context "request is invalid" do
      before do
        subject.stub(:recipes_list) { raise ArgumentError, "invalid request" }
      end

      it "returns 401 status" do
        response = subject.perform(:recipes_list)
        expect(response[:status]).to eq 401
      end
    end

  end

  describe "#perform recipe_details" do
    let(:valid_id) { subject.perform(:recipes_list)[:data].first.dig(:id) }

    context "when resource is found" do
      it "returns correct response for recipe" do
        response = subject.perform(:recipe_details, valid_id)

        expect(response.keys).to match_array [:data, :status]
        expect(response[:status]).to eq(200)
      end

      it "returns correct fields for recipe" do
        response = subject.perform(:recipe_details, valid_id)
        expect(response[:data].keys).to match_array [:title, :image, :description, :chef_name, :tags_list]
      end
    end

    context "resource is not found" do
      it "returns error status" do
        response = subject.perform(:recipe_details, 1)
        expect(response[:status]).to eq(404)
      end
    end

    context "request is invalid" do
      before do
        subject.stub(:recipe_details) { raise ArgumentError, "invalid request" }
      end

      it "returns 401 status" do
        response = subject.perform(:recipe_details, valid_id)
        expect(response[:status]).to eq 401
      end
    end
  end
end