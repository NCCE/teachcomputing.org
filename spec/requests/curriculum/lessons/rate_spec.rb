require 'rails_helper'

RSpec.describe Curriculum::LessonsController do
  include_examples 'rateable',
                   :create_curriculum_lesson_rating_path,
                   :update_curriculum_lesson_rating_path,
                   :update_curriculum_lesson_rating_choices,
                   :lesson,
                   '4b2caacf-60d9-456e-a516-f0cb89a7c6fb',
                   '058e787c-32b7-4175-89c1-efe793a78a30'
end
