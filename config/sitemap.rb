SitemapGenerator::Sitemap.default_host = 'https://teachcomputing.org'
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: ENV['AWS_S3_BUCKET'],
                                                                    fog_region: ENV['AWS_S3_REGION'])
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{ENV['AWS_S3_REGION']}.amazonaws.com/#{ENV['AWS_S3_BUCKET']}/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily'
  add '/about', changefreq: 'monthly'
  add '/accessibility-statement', changefreq: 'monthly'
  add '/bursary', changefreq: 'monthly'
  add '/certification', changefreq: 'monthly'
  add '/courses', changefreq: 'daily'
  add '/cs-accelerator', changefreq: 'monthly'
  add '/contact', changefreq: 'monthly'
  add '/get-involved', changefreq: 'monthly'
  add '/hubs', changefreq: 'monthly'
  add '/news', changefreq: 'daily'
  add '/offer', changefreq: 'monthly'
  add '/press', changefreq: 'daily'
  add '/resources', changefreq: 'monthly'
  add '/privacy', changefreq: 'monthly'
  add '/terms-conditions', changefreq: 'monthly'

  Achiever::Course::Template.all.each do |course|
    add course_path(id: course.activity_code, name: course.title.parameterize), changefreq: 'monthly'
  end
end
