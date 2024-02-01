require "rails_helper"

describe ApplicationHelper do
  describe("#auth_url") do
    it "returns the correct url" do
      expect(helper.auth_url).to eq "/auth/stem"
    end
  end

  describe("#create_account_url") do
    it "returns the correct url" do
      allow(ENV).to receive(:[]).with("BYPASS_OAUTH").and_return("false")
      allow(ENV).to receive(:[]).with("STEM_OAUTH_SITE").and_return("")
      expect(helper.create_account_url).to match(/register/)
    end

    it "returns the login url when we are faking login" do
      allow(ENV).to receive(:fetch).with("BYPASS_OAUTH", "false").and_return("true")
      expect(helper.create_account_url).to match(login_path)
    end
  end

  describe("#news_url") do
    it "returns the correct url" do
      expect(helper.news_url).to eq(cms_posts_url(tag: :news))
    end
  end

  describe("#press_url") do
    it "returns the correct url" do
      expect(helper.press_url).to eq(cms_posts_url(tag: :press))
    end
  end

  describe("#safe_redirect_url") do
    it "allows teachcomputing url" do
      url = "https://teachcomputing.org/courses/"
      expect(helper.safe_redirect_url(url)).to eq(url)
    end

    it "allows stem url" do
      url = "https://www.stem.org.uk/resources"
      expect(helper.safe_redirect_url(url)).to eq(url)
    end

    it "allows staging url" do
      url = "https://staging-teachcomputing.org/courses/"
      expect(helper.safe_redirect_url(url)).to eq(url)
    end

    it "allows stem staging url" do
      url = "https://www-stage.stem.org.uk/resources"
      expect(helper.safe_redirect_url(url)).to eq(url)
    end

    it "allows teachcomputing review app url" do
      url = "https://teachcomputing-staging-pr-460.herokuapp.com/courses/"
      expect(helper.safe_redirect_url(url)).to eq(url)
    end

    it "does not allow urls that are not whitelisted" do
      url = "https://3v1l-h4x0rs.com/steal-your-details"
      expect(helper.safe_redirect_url(url)).to be_nil
    end
  end

  describe("#yield_meta_tag") do
    it "returns the default text if a value is not set" do
      default = "testing"
      expect(helper.yield_meta_tag(:title, default)).to eq(default)
    end

    it "returns the custom text if a value is set" do
      default = "testing"
      custom = "custom"
      helper.meta_tag(:title, custom)
      expect(helper.yield_meta_tag(:title, default)).to eq(custom)
    end
  end
end
