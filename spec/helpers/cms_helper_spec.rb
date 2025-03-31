require "rails_helper"

describe CmsHelper, type: :helper do
  context("cms_image") do
    let(:small_image) {
      Cms::Models::ImageComponents::Image.new(
        url: "http://media.teachcomputing.org/an-image.png",
        alt: "",
        caption: "",
        formats: {
          small: {url: "http://media.teachcomputing.org/an-image-small.png"},
          medium: {url: "http://media.teachcomputing.org/an-image-medium.png"},
          large: {url: "http://media.teachcomputing.org/an-image-large.png"}
        },
        default_size: :small
      )
    }

    let(:medium_image) {
      Cms::Models::ImageComponents::Image.new(
        url: "http://media.teachcomputing.org/an-image.png",
        alt: "",
        caption: "",
        formats: {
          small: {url: "http://media.teachcomputing.org/an-image-small.png"},
          medium: {url: "http://media.teachcomputing.org/an-image-medium.png"},
          large: {url: "http://media.teachcomputing.org/an-image-large.png"}
        },
        default_size: :medium
      )
    }

    let(:image_missing_format) {
      Cms::Models::ImageComponents::Image.new(
        url: "http://media.teachcomputing.org/an-image.png",
        alt: "",
        caption: "",
        formats: {
          small: {url: "http://media.teachcomputing.org/an-image-small.png"}
        },
        default_size: :medium
      )
    }

    it "should render requested image size when available" do
      expect(helper.cms_image(medium_image)).to include("src=\"http://media.teachcomputing.org/an-image-medium.png\"")
      expect(helper.cms_image(small_image)).to include("src=\"http://media.teachcomputing.org/an-image-small.png\"")
    end

    it "should render default image if size not in formats" do
      expect(helper.cms_image(image_missing_format)).to include("src=\"http://media.teachcomputing.org/an-image.png\"")
    end
  end
end
