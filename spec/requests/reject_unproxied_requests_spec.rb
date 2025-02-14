require "rails_helper"

RSpec.describe Rack::Attack do
  subject { get "/primary-teachers", headers: headers }

  let(:reject_uproxied_requests) { "false" }
  let(:headers) { {} }
  let(:cloudflare_ips) { [] }
  let(:ips_v4_status) { 200 }

  around do |example|
    ClimateControl.modify REJECT_UNPROXIED_REQUESTS: reject_uproxied_requests do
      example.run
    end
  end

  before do
    allow(CloudflareRails::Importer).to receive(:cloudflare_ips).and_return(cloudflare_ips)
  end

  shared_examples "a successful request" do
    it { is_expected.to eq 200 }
  end

  shared_examples "a rejected request" do
    it { is_expected.to eq 403 }
  end

  context "when REJECT_UNPROXIED_REQUESTS is false" do
    it_behaves_like "a successful request"

    describe "when the last forwarded IP is a non-cloudflare IP" do
      let(:cloudflare_ips) { %w[192.168.0.0/22 fd80::/80].map { |i| IPAddr.new(i) } }
      let(:x_forwarded_for) { "192.168.0.1" }
      let(:headers) { {"X-Forwarded-For": x_forwarded_for} }

      it_behaves_like "a successful request"
    end

    describe "when the request comes in direct to heroku" do
      let(:headers) { {Host: "foobar.herokuapp.com"} }

      it_behaves_like "a successful request"
    end
  end

  context "when REJECT_UNPROXIED_REQUESTS is TRUE" do
    let(:reject_uproxied_requests) { "TRUE" }

    describe "when the request comes in direct to heroku" do
      let(:headers) { {Host: "foobar.herokuapp.com"} }

      it_behaves_like "a rejected request"
    end

    describe "when cloudflare IPs are set" do
      let(:cloudflare_ips) { %w[192.168.0.0/22 fd80::1/80].map { |i| IPAddr.new(i) } }

      it_behaves_like "a rejected request"

      context "when x-forwarded-for is set" do
        let(:headers) { {"X-Forwarded-For": x_forwarded_for} }

        describe "when X-Forwarded-For is empty" do
          let(:x_forwarded_for) { "" }

          it_behaves_like "a rejected request"
        end

        describe "when X-Forwarded-For is set to a cloudflare IP" do
          let(:x_forwarded_for) { "1.2.3.4 4.5.6.7 192.168.0.1" }

          it_behaves_like "a successful request"
        end

        describe "when X-Forwarded-For has extra spaces, commas" do
          let(:x_forwarded_for) { " , 192.168.0.1 , " }

          it_behaves_like "a successful request"
        end

        describe "when X-Forwarded-For is set to a non-cloudflare IP" do
          let(:x_forwarded_for) { "1.2.3.4 4.5.6.7" }

          it_behaves_like "a rejected request"
        end
      end
    end
  end
end
