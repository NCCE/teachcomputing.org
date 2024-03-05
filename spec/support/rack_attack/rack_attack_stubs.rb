module RackAttackStubs
  def stub_cloudflare_ip_lookup
    stub_request(:get, "https://www.cloudflare.com/ips-v4/")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Host" => "www.cloudflare.com",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: "", headers: {})

    stub_request(:get, "https://www.cloudflare.com/ips-v6/")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Host" => "www.cloudflare.com",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: "", headers: {})
  end
end
