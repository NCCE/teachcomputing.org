# image_pack_tag is a Webpacker helper. ViewComponent 4.x no longer auto-delegates
# helper methods, so we delegate explicitly here. Remove in Phase 3 when webpacker
# is replaced by importmap-rails and image_pack_tag becomes image_tag.
Rails.application.config.to_prepare do
  ViewComponent::Base.delegate :image_pack_tag, to: :helpers
end
