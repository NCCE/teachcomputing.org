class CommunityPresenter < SimpleDelegator
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def initialize(activity)
    super(activity)
  end

  def completed?(user)
    user.achievements.exists?(activity_id: id)
  end

  def list_item_classes(user)
    ' ncce-activity-list__item--incomplete' unless completed?(user)
  end

  def description
    (super || '').html_safe
  end

  def button_label
    'I have done this'
  end

  def inspect
    "CommunityPresenter - " + super
  end
end
