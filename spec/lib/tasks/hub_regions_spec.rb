require 'rails_helper'

RSpec.describe 'hubs:populate_regions', type: :task do 
    it 'populates database with hub regions' do 
        HubRegion.destroy_all 
        task.execute
        expect(HubRegion.count).to eq(9)
    end 
end 