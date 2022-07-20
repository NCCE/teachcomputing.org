# frozen_string_literal: true

class ProviderLogosComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(online:, dashboard: false, class_name: nil)
    @online = online
    @org_prefix = @online ? 'rpf' : 'stem'
    @dashboard = dashboard

    standard_logos = online ? online_logos : other_logos
    dashboard_logos = online ? dashboard_online_logos : other_logos
    @logos = dashboard ? dashboard_logos : standard_logos

    @class_name = class_name
  end

  def online_logos
    [
      { filename: 'tc-logo-small.svg', alt: 'Teachcomputing logo' },
      { filename: 'rpf-logo-small.svg', alt: 'Raspberry Pi Foundation logo' }
    ]
  end

  def dashboard_online_logos
    [
      { filename: 'tc-logo-small.svg', alt: 'Teachcomputing logo' },
      { filename: 'rpf-logo-small.svg', alt: 'Raspberry Pi Foundation logo' },
      { filename: 'fl-logo-small.svg', alt: 'Futurelearn logo' }
    ]
  end

  def other_logos
    [
      { filename: 'tc-logo-small.svg', alt: 'Teachcomputing logo' },
      { filename: 'stem-logo-small.svg', alt: 'STEM Learning logo' }
    ]
  end
end
