module CachingHelpers
  def file_caching_path
    path = "tmp/test/cache"
    FileUtils.mkdir_p(path)
    path
  end
end
