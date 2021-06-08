require 'rails_helper'

RSpec.describe('certificates/_achievements', type: :view) do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:complete_achievement) { create(:completed_achievement, user: user) }
  let(:two_complete_achievements) { create_list(:completed_achievement, 2, user: user) }
  let(:enrolled_achievement) { create(:achievement, user: user) }
  let(:two_enrolled_achievements) { create_list(:achievement, 2, user: user) }
  let(:programme) { create(:programme) }

  context 'when user has not completed any achievements' do
    before do
      @programme = programme
      stub_issued_badges(user.id)
      presenters = [AchievementPresenter.new(nil), AchievementPresenter.new(nil)]
      render partial: 'certificates/achievements', locals: { presenters: presenters }
    end

    it 'both achievements are  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 2)
    end

    it 'has a start courses buttons' do
      expect(rendered).to have_link('Book your course', count: 2)
    end

    it 'has prompt text' do
      expect(rendered).to have_css('.ncce-activity-list__item-text', text: /Complete your (first|second) course/)
    end
  end

  context 'when user has started one achievement' do
    before do
      @programme = programme
      presenters = [AchievementPresenter.new(enrolled_achievement), AchievementPresenter.new(nil)]
      render partial: 'certificates/achievements', locals: { presenters: presenters }
    end

    it 'one achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'one achievement is marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 1)
    end

    it 'has one start courses button' do
      expect(rendered).to have_link('Book your course', count: 1)
    end

    it 'has the activity title' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.+first.+course #{enrolled_achievement.activity.title}.*/m)}
    end
  end

  context 'when user has started two achievements' do
    before do
      stub_issued_badges(user.id)
      @programme = programme
      presenters = two_enrolled_achievements.map { |a| AchievementPresenter.new(a) }
      render partial: 'certificates/achievements', locals: { presenters: presenters, current_user: user }
    end

    it 'both achievements are marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 2)
    end

    it 'has no start courses buttons' do
      expect(rendered).to have_link('Book your course', count: 0)
    end

    it 'has the 2nd activity title' do
      two_enrolled_achievements.second do |achievement|
        expect(rendered).to have_css('.ncce-activity-list__item-text', text: /.+second.+course #{achievement.activity.title}/)
      end
    end
  end

  context 'when user has finished one achievement' do
    before do
      stub_issued_badges(user.id)
      @programme = programme
      presenters = [AchievementPresenter.new(complete_achievement), AchievementPresenter.new(enrolled_achievement)]
      render partial: 'certificates/achievements', locals: { presenters: presenters, current_user: user }
    end

    it 'one achievement is marked as inprogress' do
      expect(rendered).to have_css('.ncce-activity-list__item--inprogress', count: 1)
    end

    it 'has no start courses buttons' do
      expect(rendered).to have_link('Book your course', count: 0)
    end

    it 'has the first activity as complete' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Completed your first.+course #{complete_achievement.activity.title}.*/m)}
    end

    it 'has the second activity as in progress' do
      within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Complete your second.+course #{enrolled_achievement.activity.title}.*/m)}
    end
  end

  context 'when user has finished both achievements' do
    before do
      @programme = programme
      stub_issued_badges(user.id)
      presenters = two_complete_achievements.map { |a| AchievementPresenter.new(a) }
      render partial: 'certificates/achievements', locals: { presenters: presenters, current_user: user }
    end

    it 'no achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has no start courses buttons' do
      expect(rendered).to have_link('Book your course', count: 0)
    end

    it 'has both activities as complete' do
      two_complete_achievements.each do |achievement|
        within('.ncce-activity-list__item-text'){expect(rendered).to have_content(/.*Completed your (first|second).+course #{achievement.activity.title}.*/m)}
      end
    end
  end
end
