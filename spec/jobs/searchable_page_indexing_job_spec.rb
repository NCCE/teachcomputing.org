require 'rails_helper'

RSpec.describe SearchablePageIndexingJob, type: :job do
  describe '#perform' do
    it 'should clear out any old posts and pages' do
      create_list(:searchable_pages_ghost_page, 5)
      create_list(:searchable_pages_ghost_post, 4)

      expect(SearchablePages::GhostPage.count).to eq 5
      expect(SearchablePages::GhostPost.count).to eq 4

      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({ 'posts' => [] })
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({ 'pages' => [] })

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPage.count).to eq 0
      expect(SearchablePages::GhostPost.count).to eq 0
    end

    it 'should create searchable pages if they are pulled from ghost' do
      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({ 'posts' => [
        {
          'title' => 'Ghosty post',
          'excerpt' => 'I am a ghosty post',
          'slug' => 'ghosty-post',
          'published_at' => DateTime.now
        }
      ] })
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({ 'pages' => [
        {
          'title' => 'Ghosty page',
          'custom_excerpt' => 'I am a ghosty page',
          'slug' => 'ghosty-page',
          'published_at' => DateTime.now
        }
      ] })

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPage.first.title).to eq 'Ghosty page'
      expect(SearchablePages::GhostPage.first.excerpt).to eq 'I am a ghosty page'
      expect(SearchablePages::GhostPage.first.slug).to eq 'ghosty-page'

      expect(SearchablePages::GhostPost.first.title).to eq 'Ghosty post'
      expect(SearchablePages::GhostPost.first.excerpt).to eq 'I am a ghosty post'
      expect(SearchablePages::GhostPost.first.slug).to eq 'ghosty-post'
    end

    it 'should create them all at the same time' do
      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({ 'posts' => [
        {
          'title' => 'Ghosty post',
          'excerpt' => 'I am a ghosty post',
          'slug' => 'ghosty-post',
          'published_at' => DateTime.now
        }
      ] })
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({ 'pages' => [
        {
          'title' => 'Ghosty page',
          'custom_excerpt' => 'I am a ghosty page',
          'slug' => 'ghosty-page',
          'published_at' => DateTime.now
        }
      ] })

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPost.first.created_at).to eq SearchablePages::GhostPage.first.created_at
    end
  end
end
