# test this file in development with bin/rails sitemap:refresh:no_ping

SitemapGenerator::Sitemap.default_host = "https://teachcomputing.org"
SitemapGenerator::Sitemap.public_path = "tmp/"
if Rails.env.production?
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    fog_directory: ENV["AWS_S3_SITEMAP_BUCKET"],
    fog_region: ENV["AWS_S3_REGION"])
end
# otherwise implicitly use a file adapter

SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{ENV["AWS_S3_REGION"]}.amazonaws.com/#{ENV["AWS_S3_SITEMAP_BUCKET"]}/"
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.create do
  add "/", changefreq: "daily"
  add "/about", changefreq: "monthly"
  add "/accessibility-statement", changefreq: "monthly"
  add "/blog", changefreq: "daily"
  add "/careers-support", changefreq: "monthly"
  add "/certification", changefreq: "monthly"
  add "/contact", changefreq: "monthly"
  add "/courses", changefreq: "daily"
  add "/curriculum", changefreq: "weekly"
  add "/gcse-cs-support", changefreq: "monthly"
  add "/gender-balance", changefreq: "monthly"
  add "/get-involved", changefreq: "monthly"
  add "/i-belong", changefreq: "monthly"
  add "/impact-and-evaluation", changefreq: "monthly"
  add "/isaac-computer-science", changefreq: "monthly"
  add "/news", changefreq: "daily"
  add "/pedagogy", changefreq: "monthly"
  add "/press", changefreq: "daily"
  add "/primary-certificate", changefreq: "monthly"
  add "/primary-computing-glossary", changefreq: "monthly"
  add "/primary-online-safety-recommendations", changefreq: "monthly"
  add "/primary-senior-leaders", changefreq: "monthly"
  add "/primary-teachers", changefreq: "monthly"
  add "/school-trusts", changefreq: "monthly"
  add "/secondary-certificate", changefreq: "monthly"
  add "/secondary-certification", changefreq: "monthly"
  add "/secondary-question-banks", changefreq: "monthly"
  add "/secondary-senior-leaders", changefreq: "monthly"
  add "/secondary-teachers", changefreq: "monthly"
  add "/subject-knowledge", changefreq: "monthly"
  add "/tech-careers-videos", changefreq: "monthly"
  add "/terms-conditions", changefreq: "monthly"

  # CMS Routes
  add "/privacy", changefreq: "monthly"

  Cms::Collections::EnrichmentPage.all_records.each do |enrichment_page|
    add cms_page_path(enrichment_page.slug), changefreq: "monthly", lastmod: enrichment_page.updated_at
  end

  Cms::Collections::WebPage.all_records.each do |page|
    add cms_page_path(page.slug), changefreq: "monthly", lastmod: page.updated_at
  end

  Achiever::Course::Template.all.each do |course|
    add course_path(id: course.activity_code, name: course.title.parameterize), changefreq: "weekly"
  end

  require_relative "../app/helpers/curriculum_helper"
  extend ::CurriculumHelper
  CurriculumClient::Queries::KeyStage.all.key_stages.each do |key_stage|
    add curriculum_key_stage_units_path(key_stage.slug)
    key_stage.year_groups.each do |year_group|
      add curriculum_key_stage_units_path(key_stage.slug, anchor: year_group_anchor(year_group.year_number)), changefreq: "monthly"
    end

    key_stage.year_groups.each do |year_group|
      year_group.units.each do |unit|
        add curriculum_key_stage_unit_path(key_stage.slug, unit.slug), changefreq: "monthly"
        queried_unit = CurriculumClient::Queries::Unit.one(unit.slug, key_stage.slug)&.unit
        if queried_unit&.lessons
          queried_unit.lessons.each do |lesson|
            add curriculum_key_stage_unit_lesson_path(key_stage.slug, unit.slug, lesson.slug), changefreq: "monthly"
          end
        end
      end
    end
  end
end
