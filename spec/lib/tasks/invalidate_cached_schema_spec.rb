require 'rails_helper'

RSpec.describe 'rake invalidate_cached_schema', type: :task do
  it 'should clear curriculum schema cache' do
    expect(Rails.cache).to recieve(:delete).with('curriculum_schema')
    task.execute
  end
end
