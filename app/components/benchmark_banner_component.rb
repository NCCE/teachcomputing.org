# frozen_string_literal: true

class BenchmarkBannerComponent < ViewComponent::Base
  def initialize(icons: [], class_name: nil, align_right: false)
    @icons = icons
    @align_right = align_right
    @class_name = class_name
  end

  def label_text
    "Benchmark".pluralize(@icons.length)
  end

  def icon_classes
    classes = ["benchmark-banner__icons"]
    classes << "benchmark-banner__icons--align-right" if @align_right
  end
end
