class SecondaryQuestionBanksComponent < ViewComponent::Base
    include ViewComponent::Translatable
  
    def initialize(
      text: nil,
      link_title: nil,
      tracking_event_category: nil,
      tracking_event_label: nil,
      bottom_margin: true,
      class_name: nil
    )
      @text = text
      @link_title = link_title
      @tracking_event_category = tracking_event_category
      @bottom_margin = bottom_margin
      @class_name = class_name
    end
  end