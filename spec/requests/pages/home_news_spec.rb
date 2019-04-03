require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET #home _news' do
    context 'featured posts' do
      before do
        Rails.cache.clear
        stub_featured_posts
        get root_path
      end

      it 'assigns @featured_posts' do
        expect(assigns(:featured_posts)).to be_a(Array)
      end

      it 'has correct number of posts' do
        expect(assigns(:featured_posts).length).to eq(2)
      end
    end

    context 'featured posts errors don\'t affect cache' do
      before do
        Rails.cache.clear
        stub_featured_posts
        get root_path
        stub_featured_posts_error
        get root_path
      end

      it 'assigns @featured_posts' do
        expect(assigns(:featured_posts)).to be_a(Array)
      end

      it 'has 2 cached posts' do
        expect(assigns(:featured_posts).length).to eq(2)
      end
    end

    context 'featured posts error' do
      before do
        Rails.cache.clear
        stub_featured_posts_error
        get root_path
      end

      it 'assigns @featured_posts' do
        expect(assigns(:featured_posts)).to be_a(Array)
      end

      it 'has 0 posts' do
        expect(assigns(:featured_posts).length).to eq(0)
      end
    end
  end
end
