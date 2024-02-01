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

      # Cloudflare IPs are fetched dynamically and cached.  If the list is
      # empty then don't reject anything.
      next false if ::Rails.application.config.cloudflare.ips.empty?

      forwarded_for_header = request.get_header("HTTP_X_FORWARDED_FOR").to_s
      last_forwarded_for_ip = forwarded_for_header.split(/[,\s]+/).last

      # If we've not got a forwarded IP, reject
      unless last_forwarded_for_ip
        ::Rails.logger.warn "Rack Attack filtering: rejected request to #{request.url} with missing/malformed X-Forwarded-For header #{forwarded_for_header.inspect}"
        next true
      end

      # If the IP doesn't appear in any of the ranges, reject
      unless ::Rails.application.config.cloudflare.ips.any? { |ip_range| ip_range.include?(last_forwarded_for_ip) }
        ::Rails.logger.warn "Rack Attack filtering: rejected request to #{request.url} from a non Cloudflare IP #{last_forwarded_for_ip}"
        next true
      end

      false
    end
  end
end
