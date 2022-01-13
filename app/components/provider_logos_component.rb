# frozen_string_literal: true

class ProviderLogosComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(online:, inline: false, class_name: nil)
    @online = online
    @org_prefix = @online ? 'rpf' : 'stem'
    @inline = inline
    @class_name = class_name
  end
end
