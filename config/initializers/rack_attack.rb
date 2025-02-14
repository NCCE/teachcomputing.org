# When hosted on Heroku set ENV["REJECT_UNPROXIED_REQUESTS"] to TRUE to prevent responding to requests via *.herokuapp.com domain
module Rack
  class Attack
    blocklist("reject unproxied requests") do |request|
      next false unless ENV.fetch("REJECT_UNPROXIED_REQUESTS", "FALSE").upcase == "TRUE"

      # Block requests that go straight to heroku.
      if request.host.include?("herokuapp")
        ::Rails.logger.warn "Rack Attack filtering: rejected request to #{request.url} as it went direct to #{request.host}"
        next true
      end

      forwarded_for_header = request.get_header("HTTP_X_FORWARDED_FOR").to_s

      unless request.cloudflare?
        ::Rails.logger.warn "Rack Attack filtering: rejected request to #{request.url} with #{forwarded_for_header}"
        next true
      end
      false
    end
  end
end
