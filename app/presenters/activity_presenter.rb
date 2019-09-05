
class ActivityPresenter < SimpleDelegator
  include ProgrammesHelper
  attr_reader :empty

  def initialize(achievement)
    super(achievement)
    @empty = achievement.nil?
  end

  def empty?
    @empty
  end

  def button_label(args = {})
    'Find a course'
  end

  def button_url(args = {})
    '/'
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} course"
  end

  def prompt_text(index)
    "Complete your #{index_to_word_ordinal(index)} course"
  end

  def inspect
    super + "\n\nActivityPresenter - empty? #{empty?}\n\n"
  end
end
