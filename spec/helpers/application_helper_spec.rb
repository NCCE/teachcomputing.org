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
      expect(helper.create_account_url).to match("#{Rails.application.config.stem_account_site}/u/signup")
    end

    it "returns the login url when we are faking login" do
      allow(Rails.application.config).to receive(:bypass_oauth).and_return(true)
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

  describe "#govuk_padding_classes" do
    it "should set padding classes correctly" do
      padding_classes = helper.govuk_padding_classes({
        left: 1,
        right: 2,
        top: 3,
        bottom: 4
      })
      expect(padding_classes).to include("govuk-!-padding-left-1")
      expect(padding_classes).to include("govuk-!-padding-right-2")
      expect(padding_classes).to include("govuk-!-padding-top-3")
      expect(padding_classes).to include("govuk-!-padding-bottom-4")
    end

    it "should convert all correctly" do
      expect(helper.govuk_padding_classes({all: 5})).to eq(["govuk-!-padding-5"])
    end
  end

  describe "#govuk_margin_classes" do
    it "should set margin classes correctly" do
      margin_classes = helper.govuk_margin_classes({
        left: 1,
        right: 2,
        top: 3,
        bottom: 4
      })
      expect(margin_classes).to include("govuk-!-margin-left-1")
      expect(margin_classes).to include("govuk-!-margin-right-2")
      expect(margin_classes).to include("govuk-!-margin-top-3")
      expect(margin_classes).to include("govuk-!-margin-bottom-4")
    end

    it "should convert all correctly" do
      expect(helper.govuk_margin_classes({all: 5})).to eq(["govuk-!-margin-5"])
    end
  end
end
