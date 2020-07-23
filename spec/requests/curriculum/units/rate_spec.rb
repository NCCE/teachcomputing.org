require 'rails_helper'

RSpec.describe Curriculum::UnitsController do
  include_examples 'rateable', :curriculum_lesson_rating_path
end
