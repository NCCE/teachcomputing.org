SitemapGenerator::Sitemap.default_host = 'https://teachcomputing.org'
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily'
  add '/about', changefreq: 'monthly'
  add '/accelerator', changefreq: 'monthly'
  add '/certification', changefreq: 'monthly'
  add '/contact', changefreq: 'monthly'
  add '/login', changefreq: 'monthly'
  add '/news', changefreq: 'daily'
  add '/news/a-level', changefreq: 'monthly'
  add '/offer', changefreq: 'monthly'
  add '/privacy', changefreq: 'monthly'
  add '/signup-stem', changefreq: 'monthly'
  add '/terms-conditions', changefreq: 'monthly'
end
