SitemapGenerator::Sitemap.default_host = "https://teachcomputing.org"
SitemapGenerator::Sitemap.public_path = "tmp/"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: "AWS",
  aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
  aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  fog_directory: ENV["AWS_S3_SITEMAP_BUCKET"],
  fog_region: ENV["AWS_S3_REGION"])
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{ENV["AWS_S3_REGION"]}.amazonaws.com/#{ENV["AWS_S3_SITEMAP_BUCKET"]}/"
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.create do
  add "/", changefreq: "daily"
  add "/about", changefreq: "monthly"
  add "/accessibility-statement", changefreq: "monthly"
  add "/bursary", changefreq: "monthly"
  add "/careers-week", changefreq: "monthly"
  add "/certification", changefreq: "monthly"
  add "/courses", changefreq: "daily"
  add "/subject-knowledge", changefreq: "monthly"
  add "/contact", changefreq: "monthly"
  add "/gender-balance", changefreq: "monthly"
  add "/i-belong", changefreq: "monthly"
  add "/get-involved", changefreq: "monthly"
  add "/home-teaching", changefreq: "weekly"
  add "/home-teaching-key-stage-1", changefreq: "daily"
  add "/home-teaching-key-stage-2", changefreq: "daily"
  add "/home-teaching-key-stage-3", changefreq: "daily"
  add "/home-teaching-key-stage-3-mobile-app-development", changefreq: "daily"
  add "/home-teaching-key-stage-3-mobile-app-development-lesson-1", changefreq: "weekly"
  add "/home-teaching-key-stage-3-mobile-app-development-lesson-2", changefreq: "weekly"
  add "/home-teaching-key-stage-4", changefreq: "daily"
  add "/home-teaching-key-stage-5", changefreq: "daily"
  add "/hubs", changefreq: "monthly"
  add "/news", changefreq: "daily"
  add "/offer", changefreq: "monthly"
  add "/press", changefreq: "daily"
  add "/primary-certificate", changefreq: "monthly"
  add "/primary-teachers", changefreq: "monthly"
  add "/privacy", changefreq: "monthly"
  add "/secondary-certificate", changefreq: "monthly"
  add "/secondary-teachers", changefreq: "monthly"
  add "/terms-conditions", changefreq: "monthly"

  Achiever::Course::Template.all.each do |course|
    add course_path(id: course.activity_code, name: course.title.parameterize), changefreq: "weekly"
  end
end
