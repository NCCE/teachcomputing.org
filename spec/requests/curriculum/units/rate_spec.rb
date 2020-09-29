 require 'rails_helper'

RSpec.describe Curriculum::UnitsController do
  include_examples 'rateable',
                   :create_curriculum_unit_rating_path,
                   :update_curriculum_unit_rating_path,
                   :unit,
                   '63ba977a-0b50-43f5-ae98-5c4bc8c113b5',
                   'b849d81f-3348-47bb-a086-3aa586b8cc3d'
end
