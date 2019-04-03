require 'rails_helper'

RSpec.describe('pages/home/_ghost-news-feed', type: :view) do
  before do
    Rails.cache.clear
  end

  context 'has featured posts' do
    before do
      stub_featured_posts
      @featured_posts = Ghost.new.get_featured_posts
      render
    end

    it('renders the correct number of cards') do
      expect(rendered).to(have_css('.ncce-news-and-updates__panel', count: 2))
    end
  end

  context 'has 0 posts' do
    before do
      stub_featured_posts_error
      @featured_posts = Ghost.new.get_featured_posts
      render
    end

    it('renders the correct number of cards') do
      expect(rendered).to(have_css('.ncce-news-and-updates__panel', count: 0))
    end
  end
end
