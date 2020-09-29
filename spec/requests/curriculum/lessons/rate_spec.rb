require 'rails_helper'

RSpec.describe Curriculum::LessonsController do
  include_examples 'rateable',
                   :create_curriculum_lesson_rating_path,
                   :update_curriculum_lesson_rating_path,
                   :lesson,
                   'aabac8ca-2c9c-4ac0-a90b-bcca28cec53c',
                   'f23d70ee-8e00-44f7-bbf8-2122fd8717f0',
                   'c4787d12-4f5d-4cc2-a979-b1ddd904bd02'
end
