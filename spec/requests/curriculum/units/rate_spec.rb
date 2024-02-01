require "rails_helper"

RSpec.describe Curriculum::UnitsController do
  before do
    client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
    allow(CurriculumClient::Connection).to receive(:connect).and_return(client)
  end

  include_examples "rateable",
    :create_curriculum_unit_rating_path,
    :update_curriculum_unit_rating_path,
    :update_curriculum_unit_rating_choices_path,
    :unit,
    "63ba977a-0b50-43f5-ae98-5c4bc8c113b5",
    "b849d81f-3348-47bb-a086-3aa586b8cc3d"
end
