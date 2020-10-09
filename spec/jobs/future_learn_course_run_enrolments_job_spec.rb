require 'rails_helper'

RSpec.describe FutureLearnCourseRunEnrolmentsJob, type: :job do
  it 'does something' do
    described_class.perform_now(course_uuid: 'asdf', run_uuid: 'asdfsa')
  end
end
