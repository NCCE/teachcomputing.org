# frozen_string_literal: true

class ProviderLogosComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(provider: "stem-learning", dashboard: true, class_name: nil, no_top_border: false)
    @no_top_border = no_top_border
    @provider = provider
    @dashboard = dashboard

    # Won't display logos for retired course providers to minimize untested layouts and stale logos. 'future-learn' courses were
    # retired in February 2023.
    @logos = (provider == "stem-learning") ? logos : []

    @class_name = class_name
  end

  def logos
    # no alt texts as they don't add to the information in provider_text
    [
      {filename: "ncce-logo.svg", alt: ""},
      {filename: "stem-logo-small.svg", alt: ""}
    ]
  end
end
