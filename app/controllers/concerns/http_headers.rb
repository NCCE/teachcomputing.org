module HttpHeaders
  # Respond with 'Cache-Control: no-store' header. Use as a controller after_action
  def discourage_caching
    headers["cache-control"] = "no-store"
  end
end
