require "rails_helper"

RSpec.describe SearchableSitePages do
  include Rails.application.routes.url_helpers

  describe ".all" do
    it "should return many page entries" do
      # Prevent calls to graphql and database
      allow_any_instance_of(SearchableSitePages).to receive(:build_pathway_pages).and_return(nil)
      allow_any_instance_of(SearchableSitePages).to receive(:build_curriculum_pages).and_return(nil)

      expect(SearchableSitePages.all.size).to be > 10
    end

    it "all entries should have a title, excerpt, and path" do
      # Prevent calls to graphql and database
      allow_any_instance_of(SearchableSitePages).to receive(:build_pathway_pages).and_return(nil)
      allow_any_instance_of(SearchableSitePages).to receive(:build_curriculum_pages).and_return(nil)

      expect(SearchableSitePages.all.all? { _1[:title].present? && _1[:excerpt].present? && _1[:path].present? }).to be true
    end

    it "creates entries for pathways" do
      # Prevent calls to graphql
      allow_any_instance_of(SearchableSitePages).to receive(:build_curriculum_pages).and_return(nil)

      primary_certificate = create(:primary_certificate)
      secondary_certificate = create(:secondary_certificate)

      create(:pathway, programme: primary_certificate, title: "Foo pathway", enrol_copy: "Foo pathway enrol copy", slug: "asdf")
      create(:pathway, programme: secondary_certificate, title: "Bar pathway", enrol_copy: "Bar pathway enrol copy", slug: "fdsa")

      results = SearchableSitePages.all

      expect(results.include?({title: "Teach primary computing certificate pathway - Foo pathway", excerpt: "Foo pathway enrol copy", path: pathway_path("asdf")})).to be true
      expect(results.include?({title: "Teach secondary computing certificate pathway - Bar pathway", excerpt: "Bar pathway enrol copy", path: pathway_path("fdsa")})).to be true
    end

    it "creates entries for curriculum key stages" do
      # Prevent calls to graphql and database
      allow_any_instance_of(SearchableSitePages).to receive(:build_pathway_pages).and_return(nil)
      allow(CurriculumClient::Queries::Lesson).to receive(:all).and_return(OpenStruct.new(lessons: []))
      allow(CurriculumClient::Queries::KeyStage).to receive(:all).and_return(OpenStruct.new(
        key_stages: [
          OpenStruct.new(
            slug: "aaaa",
            short_title: "KS1",
            title: "Key stage 1",
            description: "bbbb",
            year_groups: [
              OpenStruct.new(
                year_number: "2",
                units: [
                  OpenStruct.new(
                    slug: "cccc",
                    title: "dddd",
                    description: "eeee"
                  )
                ]
              ),
              OpenStruct.new(
                year_number: "Pre-GCSE",
                units: [
                  OpenStruct.new(
                    slug: "cccc",
                    title: "dddd",
                    description: "eeee"
                  )
                ]
              )
            ]
          )
        ]
      ))

      results = SearchableSitePages.all

      expect(results.include?({title: "Key stage 1 resources", excerpt: "bbbb", path: curriculum_key_stage_units_path(key_stage_slug: "aaaa")})).to be true
      expect(results.include?({title: "KS1 resources - Year 2 - dddd", excerpt: "eeee", path: curriculum_key_stage_unit_path(key_stage_slug: "aaaa", unit_slug: "cccc")})).to be true
      expect(results.include?({title: "KS1 resources - Pre-GCSE - dddd", excerpt: "eeee", path: curriculum_key_stage_unit_path(key_stage_slug: "aaaa", unit_slug: "cccc")})).to be true
    end

    it "creates entries for curriculum lessons" do
      # Prevent calls to graphql and database
      allow_any_instance_of(SearchableSitePages).to receive(:build_pathway_pages).and_return(nil)
      allow(CurriculumClient::Queries::Lesson).to receive(:all).and_return(OpenStruct.new(lessons: [
        OpenStruct.new(
          title: "aaaa",
          description: "bbbb",
          slug: "cccc",
          unit: OpenStruct.new(
            slug: "dddd",
            title: "eeee",
            year_group: OpenStruct.new(
              year_number: "Pre-GCSE",
              key_stage: OpenStruct.new(
                slug: "ffff",
                short_title: "KS1"
              )
            )
          )
        )
      ]))
      allow(CurriculumClient::Queries::KeyStage).to receive(:all).and_return(OpenStruct.new(key_stages: []))

      results = SearchableSitePages.all

      expect(results.include?({title: "KS1 resources - Pre-GCSE - eeee - aaaa", excerpt: "bbbb", path: curriculum_key_stage_unit_lesson_path(key_stage_slug: "ffff", unit_slug: "dddd", lesson_slug: "cccc")})).to be true
    end
  end
end
