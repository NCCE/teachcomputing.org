class CommunityPresenter < SimpleDelegator
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def initialize(activity, programme_id)
    @programme = Programme.find(programme_id)
    super(activity)
  end

  def completed?(user)
    user.achievements.exists?(activity_id: id, programme_id: @programme.id)
  end

  def list_item_classes(user)
    ' ncce-activity-list__item--incomplete' unless completed?(user)
  end

  def show_separator_class
    ' ncce-activity-list__item--separate' if slug == 'contribute-to-online-discussion'
  end

  def description
    (super || '').html_safe
  end

  def button_label
    'Submit evidence'
  end

  def inspect
    "CommunityPresenter - #{super}"
  end
end
