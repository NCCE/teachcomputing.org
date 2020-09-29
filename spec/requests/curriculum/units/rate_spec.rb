 require 'rails_helper'

RSpec.describe Curriculum::UnitsController do
  include_examples 'rateable',
                   :create_curriculum_unit_rating_path,
                   :update_curriculum_unit_rating_path,
                   :unit,
                   '1cbd71df-4f32-44f2-88a6-e4736b5ffabb',
                   'e4049d28-a258-406b-a32d-d72204ed24d5',
                   'ee9421f6-47e2-4da9-ae12-1a814b615bb6'
end
