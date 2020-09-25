require 'rails_helper'

RSpec.describe Curriculum::UnitsController do
  include_examples 'rateable', :create_curriculum_unit_rating_path, :unit
end
