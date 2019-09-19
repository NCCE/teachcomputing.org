class CommunityPresenter < SimpleDelegator
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def initialize(activity)
    super(activity)
  end

  def completed?
    !achievements.nil? && achievements.any? && achievements.first.complete?
  end

  def list_item_classes
    ' ncce-activity-list__item--incomplete' unless completed?
  end

  def description
    (super || '').html_safe
  end

  def button_label
    'I have done this'
  end

  def inspect
    "CommunityPresenter - completed? #{completed?}\n" + super
  end
end
