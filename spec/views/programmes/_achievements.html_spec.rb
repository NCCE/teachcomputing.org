require 'rails_helper'

RSpec.describe('programmes/_achievements', type: :view) do
  let(:user) { create(:user) }
  let(:complete_achievement) { create(:completed_achievement, user: user) }
  let(:two_complete_achievements) { create_list(:completed_achievement, 2, user: user) }
  let(:commenced_achievement) { create(:achievement, user: user) }
  let(:two_commenced_achievements) { create_list(:achievement, 2, user: user) }

  context 'when user has not completed any achievements' do
    before do
      presenters = [ActivityPresenter.new(nil), ActivityPresenter.new(nil)]
      render partial: 'programmes/achievements', locals: { presenters: presenters }
    end

    it 'both achievements are  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 2)
    end

    it 'has a find courses buttons' do
      expect(rendered).to have_link('Find a course', count: 2)
    end

    it 'has prompt text' do
      expect(rendered).to have_css('.ncce-activity-list__item-text', text: /Complete your (first|second) course/)
    end
  end

  context 'when user has started one achievement' do
    before do
      presenters = [ActivityPresenter.new(commenced_achievement), ActivityPresenter.new(nil)]
      render partial: 'programmes/achievements', locals: { presenters: presenters }
    end

    it 'one achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'one achievement is marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 1)
    end

    it 'has one find courses button' do
      expect(rendered).to have_link('Find a course', count: 1)
    end

    it 'has the activity title' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.+first.+course #{commenced_achievement.activity.title}.*/m)}
    end
  end

  context 'when user has started two achievements' do
    before do
      presenters = two_commenced_achievements.map { |a| ActivityPresenter.new(a) }
      render partial: 'programmes/achievements', locals: { presenters: presenters }
    end

    it 'both achievements are marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 2)
    end

    it 'has no find courses buttons' do
      expect(rendered).to have_link('Find a course', count: 0)
    end

    it 'has the 2nd activity title' do
      two_commenced_achievements.second do |achievement|
        expect(rendered).to have_css('.ncce-activity-list__item-text', text: /.+second.+course #{achievement.activity.title}/)
      end
    end
  end

  context 'when user has finished one achievement' do
    before do
      presenters = [ActivityPresenter.new(complete_achievement), ActivityPresenter.new(commenced_achievement)]
      render partial: 'programmes/achievements', locals: { presenters: presenters }
    end

    it 'one achievement is marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 1)
    end

    it 'has no find courses buttons' do
      expect(rendered).to have_link('Find a course', count: 0)
    end

    it 'has the first activity as complete' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Completed your first.+course #{complete_achievement.activity.title}.*/m)}
    end

    it 'has the second activity as in progress' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Complete your second.+course #{commenced_achievement.activity.title}.*/m)}
    end
  end

  context 'when user has finished both achievements' do
    before do
      presenters = two_complete_achievements.map { |a| ActivityPresenter.new(a) }
      render partial: 'programmes/achievements', locals: { presenters: presenters }
    end

    it 'no achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has no find courses buttons' do
      expect(rendered).to have_link('Find a course', count: 0)
    end

    it 'has both activities as complete' do
      two_complete_achievements.each do |achievement|
        within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Completed your (first|second).+course #{achievement.activity.title}.*/m)}
      end
    end
  end
end
