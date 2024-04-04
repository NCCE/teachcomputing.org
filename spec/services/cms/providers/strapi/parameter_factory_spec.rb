require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::ParameterFactory do
  context "for BlogPreview" do
    it "should filter blog posts" do
      freeze_time do
        params = described_class.generate_parameters(Cms::Models::BlogPreview)
        expect(params[:filters]).to have_key(:publishDate)
        expect(params[:filters][:publishDate]).to eq({"$lt": DateTime.now.strftime})
      end
    end

    it "should sort by publishDate desc" do
      params = described_class.generate_parameters(Cms::Models::BlogPreview)
      expect(params[:sort]).to include("publishDate:desc")
    end

    it "should populate featuredImage" do
      params = described_class.generate_parameters(Cms::Models::BlogPreview)[:populate]
      expect(params).to have_key(:featuredImage)
      expect(params[:featuredImage]).to eq({populate: [:alternativeText]})
    end
  end
end
