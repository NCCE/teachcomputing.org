require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::ComponentParameterFactory do
  %i[
    text_with_asides_parameters
    horizontal_card_parameters
    split_horizontal_card_parameters
    text_block_parameters
    question_and_answer_parameters
    full_width_banner_parameters
    icon_block_parameters
    card_wrapper_parameters
    resource_card_parameters
    picture_card_parameters
    testimonial_row_parameters
    numbered_icon_list_parameters
    image_params
    content_block_file_link
    content_block_linked_picture
  ].each do |method|
    it "should return hash" do
      expect(described_class.send(method)).to be_a(Hash)
    end

    it "should have populate key" do
      expect(described_class.send(method)).to have_key(:populate)
    end
  end
end
