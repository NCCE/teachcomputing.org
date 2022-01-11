class AchievementPresenter < SimpleDelegator
  include ProgrammesHelper
  attr_reader :empty

  def initialize(achievement, programme = nil)
    super(achievement)
    @empty = achievement.nil?
    @programme = programme
  end

  def empty?
    @empty
  end

  def button_label(*)
    'Book a course'
  end

  def button_url(*)
    '/'
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} course"
  end

  def prompt_text(index)
    "Complete your #{index_to_word_ordinal(index)} course"
  end

  def inspect
    "AchievementPresenter - empty? #{empty?}\n" + super
  end

  def t(key)
    scope = "presenters.#{self.class.to_s.underscore.gsub('/', '.')}"
    I18n.t(key, scope: scope, default: I18n.t(key))
  end
end
