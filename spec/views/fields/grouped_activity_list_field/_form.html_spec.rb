require "rails_helper"

RSpec.describe "fields/grouped_activity_list_field/form", type: :view do
  let!(:ks3_certificate) { create(:cs_accelerator) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:activity_ks3_1) { create(:activity, category: "online") }
  let!(:activity_primary_1) { create(:activity, category: "face-to-face") }

  before do
    create(:programme_activity, programme: ks3_certificate, activity: activity_ks3_1)
    create(:programme_activity, programme: primary_certificate, activity: activity_primary_1)

    field = GroupedActivityListField.new(:activity_id, nil, :form)
    render partial: subject, locals: {
      field:,
      f: form_builder(Achievement.new)
    }
  end

  it "should render select" do
    expect(rendered).to have_css("select")
  end

  it "should have two optgroups" do
    expect(rendered).to have_css("optgroup", count: 2)
  end

  def form_builder(object)
    ActionView::Helpers::FormBuilder.new(
      object.model_name.singular,
      object,
      Object.new.tap do |template|
        template.extend ActionView::Helpers::FormHelper
        template.extend ActionView::Helpers::FormOptionsHelper
        template.extend ActionView::Helpers::FormTagHelper
      end,
      {}
    )
  end
end
