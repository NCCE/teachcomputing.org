class CommunityPresenter < SimpleDelegator
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def initialize(activity)
    super(activity)
    @empty = activity.nil?
  end

  def empty?
    @empty
  end

  def completed?
    !@empty && has_achievement? && achievements.first.complete?
  end

  def list_item_classes(one_completed = false)
    classes = ' ncce-activity-list__item--incomplete' unless completed?
    classes = ' ncce-activity-list__item--disabled' if one_completed && !completed?
    classes
  end

  def description
    (super || '').html_safe
  end

  def button_label(args = {})
    'I have done this'
  end

  def inspect
    "CommunityPresenter - completed? #{completed?}\n" + super
  end

  private
    def has_achievement?
      !achievements.nil? && !achievements.first.nil?
    end
end

