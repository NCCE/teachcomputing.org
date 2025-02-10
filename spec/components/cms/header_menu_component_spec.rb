# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HeaderMenuComponent, type: :component do
  before do
    render_inline(described_class.new(menu_items: []))
  end
end
