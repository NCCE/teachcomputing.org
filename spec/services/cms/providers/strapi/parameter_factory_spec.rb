require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::ParameterFactory do
  context "for BlogPreview" do
    it "should filter blog posts" do
      freeze_time do
        params = described_class.generate_parameters(Cms::Models::Collections::BlogPreview)
        expect(params[:filters]).to have_key(:publishDate)
        expect(params[:filters][:publishDate]).to eq({"$lt": DateTime.now.strftime})
      end
    end

    it "should sort by publishDate desc" do
      params = described_class.generate_parameters(Cms::Models::Collections::BlogPreview)
      expect(params[:sort]).to include("publishDate:desc")
    end

    it "should populate featuredImage" do
      params = described_class.generate_parameters(Cms::Models::Collections::BlogPreview)[:populate]
      expect(params).to have_key(:featuredImage)
      expect(params[:featuredImage]).to eq({populate: [:alternativeText]})
    end
  end

  context "for WebPagePreview" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::Data::WebPagePreview)
      expect(params).to have_key(:populate)
      expect(params).to have_key(:fields)
      expect(params[:populate]).to eq({seo: {fields: [:title, :description]}})
    end
  end

  context "for PageTitle" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::Meta::PageTitle)
      expect(params).to have_key(:populate)
      expect(params).to have_key(:fields)
      expect(params[:populate]).to eq({titleImage: {populate: [:alternativeText]}})
    end
  end

  context "for Aside" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::Collections::Aside)
      expect(params).to have_key(:fields)
      expect(params).to have_key(:content)
      expect(params).to have_key(:titleIcon)
      expect(params).to have_key(:asideIcons)
    end
  end

  context "for EnrichmentList" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::Collections::EnrichmentList)
      expect(params).to have_key(:populate)
      expect(params[:populate]).to have_key(:partner_icon)
      expect(params[:populate]).to have_key(:terms)
      expect(params[:populate]).to have_key(:age_groups)
    end
  end

  context "for DynamicZone" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::DynamicZones::DynamicZone)
      expect(params).to have_key(:on)
    end
  end

  context "for Seo" do
    it "should generate correct params" do
      params = described_class.generate_parameters(Cms::Models::Meta::Seo)
      expect(params).to have_key(:fields)
      expect(params[:populate]).to eq({featuredImage: {populate: [:alternativeText]}})
    end
  end
end
