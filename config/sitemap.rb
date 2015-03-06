# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.himeneu.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add providers_path, :changefreq => 'weekly', :priority => 0.9
  @providers = Provider.select(:slug, :updated_at)
  @providers.each do |provider|
    add provider_path(provider), lastmod: provider.updated_at, :changefreq => 'daily'
  end

# SitemapGenerator::Sitemap.ping_search_engines
end
