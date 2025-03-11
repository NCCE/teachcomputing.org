# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::EmbeddedVideoComponent, type: :component do
  let(:local_video) { "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4" }
  let(:youtube_video) { "https://www.youtube.com/watch?v=-fTboqiyjxk&list=PLwcV67XMdDdJT0TkvZo6cTDSR0uJgP3Ku" }
  let(:youtube_id) { "-fTboqiyjxk" }

  context "with locally hosted video" do
    before do
      render_inline(described_class.new(
        url: local_video
      ))
    end

    it "renders the video" do
      expect(page).to have_css("video[src='#{local_video}']")
    end

    it "includes controls attribute" do
      expect(page).to have_css("video[controls]")
    end
  end

  context "with youtube video" do
    before do
      render_inline(described_class.new(
        url: youtube_video
      ))
    end

    it "renders the video" do
      expect(page).to have_css("iframe[src='https://www.youtube.com/embed/#{youtube_id}']")
    end
  end
end
