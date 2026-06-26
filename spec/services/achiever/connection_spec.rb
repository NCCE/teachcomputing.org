require "rails_helper"

RSpec.describe Achiever::Connection do
  describe "#api" do
    it "is a Faraday::Connection class" do
      expect(described_class.api.class).to eq Faraday::Connection
    end

    it "has a proxy set" do
      expect(described_class.api.proxy.host).not_to eq nil
    end

    it "verifies TLS against a custom cert store" do
      expect(described_class.api.ssl.cert_store).to be_a(OpenSSL::X509::Store)
    end
  end

  describe ".cert_store" do
    let(:starfield_r1_root) do
      OpenSSL::X509::Certificate.new(
        File.read(Rails.root.join("config/certs/starfield_tls_root_ca_r1.pem"))
      )
    end

    it "trusts the vendored Starfield TLS Root CA - R1 in addition to the system defaults" do
      # A self-signed root only verifies when it is present in the store, so this
      # proves the extra root was added on top of set_default_paths.
      expect(described_class.cert_store.verify(starfield_r1_root)).to be true
    end
  end
end
