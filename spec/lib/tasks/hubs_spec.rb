require 'rails_helper'

RSpec.describe 'hubs:populate_hubs', type: :task do 
    it 'populates the database with hubs' do 
        Rake::Task['hubs:populate_regions'].invoke
        task.execute()
        expect(Hub.count).to eq(37)
    end 
end 