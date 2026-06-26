require "faraday"
require "openssl"

class Achiever::Connection
  # TEMPORARY: the staging SmartConnector endpoint (dev3.smartmembership.net) serves
  # a TLS chain anchored on "Starfield TLS Root CA - R1", a 2025 Starfield root not yet
  # present in the platform CA bundle. OpenSSL therefore can't build a trusted chain
  # ("unable to get local issuer certificate") and every release fails at db:seed /
  # sitemap:refresh. We trust that root *in addition to* the system defaults so
  # verification stays on; production uses a healthy endpoint and is unaffected.
  # Remove once the dev3.smartmembership.net endpoint serves a chain to a
  # standard root (vendor cert-chain fix tracked separately).
  EXTRA_CA_FILE = Rails.root.join("config/certs/starfield_tls_root_ca_r1.pem")

  def self.api
    Faraday.new(url: ENV.fetch("ACHIEVER_V2_ENDPOINT")) do |conn|
      conn.adapter :net_http
      conn.request(:authorization, :basic, ENV.fetch("ACHIEVER_V2_USERNAME"), ENV.fetch("ACHIEVER_V2_PASSWORD"))
      conn.proxy = ENV.fetch("PROXY_URL") # set PROXY_URL='' if you don't need a proxy
      conn.ssl.cert_store = cert_store
    end
  end

  # System default trust store plus the extra Starfield root above. Adds trust,
  # never replaces it, so all other endpoints keep verifying normally.
  def self.cert_store
    @cert_store ||= OpenSSL::X509::Store.new.tap do |store|
      store.set_default_paths
      store.add_file(EXTRA_CA_FILE.to_s) if File.exist?(EXTRA_CA_FILE)
    end
  end
end
