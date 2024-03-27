require "rails_helper"

RSpec.describe SearchablePageIndexingJob, type: :job do
  describe "#perform" do
    it "should clear out any old posts and pages" do
      create_list(:searchable_pages_ghost_page, 5)
      create_list(:searchable_pages_ghost_post, 4)
      create_list(:searchable_pages_course, 7)
      create_list(:searchable_pages_site_page, 8)

      expect(SearchablePages::GhostPage.count).to eq 5
      expect(SearchablePages::GhostPost.count).to eq 4
      expect(SearchablePages::Course.count).to eq 7
      expect(SearchablePages::SitePage.count).to eq 8

      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({"posts" => []})
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({"pages" => []})
      allow(SearchableSitePages).to receive(:all).and_return([])
      allow(Achiever::Course::Template).to receive(:all).and_return([])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPage.count).to eq 0
      expect(SearchablePages::GhostPost.count).to eq 0
      expect(SearchablePages::Course.count).to eq 0
      expect(SearchablePages::SitePage.count).to eq 0
    end

    it "should create searchable pages if they are pulled from ghost" do
      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({"posts" => [
        {
          "title" => "Ghosty post",
          "excerpt" => "I am a ghosty post",
          "slug" => "ghosty-post",
          "published_at" => DateTime.now
        }
      ]})
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({"pages" => [
        {
          "title" => "Ghosty page",
          "custom_excerpt" => "I am a ghosty page",
          "slug" => "ghosty-page",
          "published_at" => DateTime.now
        }
      ]})
      allow(SearchableSitePages).to receive(:all).and_return([
        {
          title: "Sitey page",
          excerpt: "sitey excerpt",
          path: "/foobarbaz"
        }
      ])
      allow(Achiever::Course::Template).to receive(:all).and_return([
        OpenStruct.new(
          title: "Achiever Course",
          meta_description: "achiever description",
          activity_code: "CP123"
        )
      ])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPage.first.title).to eq "Ghosty page"
      expect(SearchablePages::GhostPage.first.excerpt).to eq "I am a ghosty page"
      expect(SearchablePages::GhostPage.first.slug).to eq "ghosty-page"

      expect(SearchablePages::GhostPost.first.title).to eq "Ghosty post"
      expect(SearchablePages::GhostPost.first.excerpt).to eq "I am a ghosty post"
      expect(SearchablePages::GhostPost.first.slug).to eq "ghosty-post"

      expect(SearchablePages::SitePage.first.title).to eq "Sitey page"
      expect(SearchablePages::SitePage.first.excerpt).to eq "sitey excerpt"
      expect(SearchablePages::SitePage.first.url).to eq "/foobarbaz"

      expect(SearchablePages::Course.first.title).to eq "Achiever Course"
      expect(SearchablePages::Course.first.excerpt).to eq "achiever description"
      expect(SearchablePages::Course.first.stem_activity_code).to eq "CP123"
    end

    it "should create them all at the same time" do
      allow_any_instance_of(Ghost).to receive(:get_posts).and_return({"posts" => [
        {
          "title" => "Ghosty post",
          "excerpt" => "I am a ghosty post",
          "slug" => "ghosty-post",
          "published_at" => DateTime.now
        }
      ]})
      allow_any_instance_of(Ghost).to receive(:get_pages).and_return({"pages" => [
        {
          "title" => "Ghosty page",
          "custom_excerpt" => "I am a ghosty page",
          "slug" => "ghosty-page",
          "published_at" => DateTime.now
        }
      ]})
      allow(SearchableSitePages).to receive(:all).and_return([
        {
          title: "Sitey page",
          excerpt: "sitey excerpt",
          url: "/foobarbaz"
        }
      ])
      allow(Achiever::Course::Template).to receive(:all).and_return([
        OpenStruct.new(
          title: "Achiever Course",
          meta_description: "achiever description",
          activity_code: "CP123"
        )
      ])

      SearchablePageIndexingJob.perform_now

      expect(SearchablePages::GhostPost.first.created_at).to eq SearchablePages::GhostPage.first.created_at
      expect(SearchablePages::SitePage.first.created_at).to eq SearchablePages::Course.first.created_at
      expect(SearchablePages::GhostPost.first.created_at).to eq SearchablePages::SitePage.first.created_at
    end
  end
end
