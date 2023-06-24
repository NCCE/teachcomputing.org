require 'rails_helper'

RSpec.describe "vital_model_checker" do
    before(:each) do 
        user = FactoryBot.create(:user)
        FactoryBot.create(:achievement, :online, user_id: user.id)
        FactoryBot.create(:achievement, :face_to_face, user_id: user.id)
    end 

    it 'displays number of Online achievements' do 
        expect(Achievement.with_category('online').count).to eq(1)
    end 

    it 'displays number of face-to-face achievements' do 
        expect(Achievement.with_category('face-to-face').count).to eq(1)
    end 
end
