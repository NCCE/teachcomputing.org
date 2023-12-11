require 'rails_helper'

RSpec.describe SiteSearch do
  describe '.search' do
    it 'it should return the most relevant results first when order is not provided' do
      close = create(:searchable_pages_ghost_post, title: 'close')
      closeish = create(:searchable_pages_ghost_post, title: 'close ish')
      create(:searchable_pages_ghost_post, title: 'not near')

      results = SiteSearch.search('close')

      expect(results).to eq [close, closeish]
    end

    it 'it should return the most newest results first when newest order is provided' do
      close = create(:searchable_pages_ghost_post, title: 'close', published_at: 2.year.ago)
      closeish = create(:searchable_pages_ghost_post, title: 'close ish', published_at: 1.years.ago)
      create(:searchable_pages_ghost_post, title: 'not near', published_at: 1.day.ago)

      results = SiteSearch.search('close', order: :published_newest)

      expect(results).to eq [closeish, close]
    end

    it 'it should return the most oldest results first when oldest order is provided' do
      close = create(:searchable_pages_ghost_post, title: 'close', published_at: 1.year.ago)
      closeish = create(:searchable_pages_ghost_post, title: 'close ish', published_at: 2.years.ago)
      create(:searchable_pages_ghost_post, title: 'not near', published_at: 1.day.ago)

      results = SiteSearch.search('close', order: :published_oldest)

      expect(results).to eq [closeish, close]
    end
  end

  describe 'Internal.cache_in_production' do
    it 'should not cache in test env' do
      allow(Rails.env).to receive(:test?).and_return(true)
      allow(Rails.env).to receive(:development?).and_return(false)
      expect(Rails.cache).to_not receive(:fetch)

      SiteSearch::Internal.cache_in_production('foo') { 1 + 2 }
    end

    it 'should not cache in development env' do
      allow(Rails.env).to receive(:test?).and_return(false)
      allow(Rails.env).to receive(:development?).and_return(true)
      expect(Rails.cache).to_not receive(:fetch)

      SiteSearch::Internal.cache_in_production('foo') { 1 + 2 }
    end

    it 'should cache in production' do
      allow(Rails.env).to receive(:test?).and_return(false)
      allow(Rails.env).to receive(:development?).and_return(false)
      expect(Rails.cache).to receive(:fetch)

      SiteSearch::Internal.cache_in_production('foo') { 1 + 2 }
    end

    it 'should return value of proc in development' do
      allow(Rails.env).to receive(:test?).and_return(false)
      allow(Rails.env).to receive(:development?).and_return(true)

      result = SiteSearch::Internal.cache_in_production('foo') { 1 + 2 }

      expect(result).to eq 3
    end

    it 'should return value of proc in production' do
      allow(Rails.env).to receive(:test?).and_return(false)
      allow(Rails.env).to receive(:development?).and_return(false)

      result = SiteSearch::Internal.cache_in_production('foo') { 1 + 2 }

      expect(result).to eq 3
    end
  end
end
