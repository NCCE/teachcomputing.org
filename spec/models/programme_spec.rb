require 'rails_helper'

RSpec.describe Programme, type: :model do
  let(:generic_programme) { create(:programme) }
  let(:programme) { create(:cs_accelerator) }
  let(:programmes) { create_list(:programme, 3) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:primary_programme) { create(:primary_certificate) }
  let(:secondary_programme) { create(:secondary_certificate) }
  let(:i_belong_programme) { create(:i_belong) }
  let(:non_enrollable_programme) { create(:programme, enrollable: false) }
  let(:user) { create(:user) }
  let(:badge) { create(:badge, :active, programme_id: programme.id) }

  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  describe 'associations' do
    it { is_expected.to have_many(:badges) }
    it { is_expected.to have_many(:pathways) }
    it { is_expected.to have_many(:activities).through(:programme_activities) }
    it { is_expected.to have_many(:users).through(:user_programme_enrolments) }
    it { is_expected.to have_many(:programme_activity_groupings) }
    it { is_expected.to have_one(:assessment) }
    it { is_expected.to have_one(:programme_complete_counter) }
    it { is_expected.to have_many(:questionnaires) }
  end

  describe 'scopes' do
    describe '#enrollable' do
      before do
        programmes
        non_enrollable_programme
      end

      it 'contains only programmes that are enrollable' do
        expect(described_class.enrollable).to eq programmes
        expect(described_class.enrollable).not_to include non_enrollable_programme
      end
    end
  end

  describe '#user_enrolled?' do
    it 'returns true if user is enrolled on the programme' do
      user_programme_enrolment
      expect(programme.user_enrolled?(user)).to be(true)
    end

    it 'returns false if user is not enrolled on the programme' do
      expect(programme.user_enrolled?(user)).to be(false)
    end

    it 'returns false if user not defined' do
      expect(programme.user_enrolled?(nil)).to be(false)
    end

    it 'returns false if user unenrolled' do
      user_programme_enrolment.transition_to(:unenrolled)
      expect(programme.user_enrolled?(user)).to be(false)
    end
  end

  describe '#cs_accelerator' do
    before do
      programme
    end

    it 'returns the cs-accelerator record' do
      expect(described_class.cs_accelerator).to eq programme
    end
  end

  describe '#primary_certificate' do
    before do
      primary_programme
    end

    it 'returns the primary record' do
      expect(described_class.primary_certificate).to eq primary_programme
    end

    it 'returns the correct type' do
      expect(described_class.primary_certificate).to be_a(Programmes::PrimaryCertificate)
    end
  end

  describe '#secondary_certificate' do
    before do
      secondary_programme
    end

    it 'returns the secondary record' do
      expect(described_class.secondary_certificate).to eq secondary_programme
    end

    it 'returns the correct type' do
      expect(described_class.secondary_certificate).to be_a(Programmes::SecondaryCertificate)
    end
  end

  describe '#i_belong' do
    before do
      i_belong_programme
    end

    it 'returns the i belong record' do
      expect(described_class.i_belong).to eq i_belong_programme
    end

    it 'returns the correct type' do
      expect(described_class.i_belong).to be_a(Programmes::IBelong)
    end
  end

  describe '#badgeable?' do
    before do
      programme
    end

    context 'with a programme but without a badge' do
      it 'returns false' do
        expect(programme.badgeable?).to be false
      end
    end

    context 'with a programme that has a badge' do
      it 'returns true when active' do
        badge
        expect(programme.badgeable?).to be true
      end

      it 'returns false when active is false' do
        badge.update(active: false)
        expect(programme.badgeable?).to be false
      end
    end
  end

  describe '#user_completed?' do
    context 'when the user is enrolled' do
      it 'returns false' do
        user_programme_enrolment
        expect(programme.user_completed?(user)).to be false
      end
    end

    context 'when the user is pending' do
      it 'returns false' do
        user_programme_enrolment.transition_to(:pending)
        expect(programme.user_completed?(user)).to be false
      end
    end

    context 'when the user is complete' do
      it 'returns true' do
        user_programme_enrolment.transition_to(:complete)
        expect(programme.user_completed?(user)).to be true
      end
    end
  end

  describe '#enough_activities_for_test?' do
    it 'returns 0' do
      expect(programmes[0].enough_activities_for_test?(user)).to be false
    end
  end

  describe '#primary_certificate?' do
    context 'when programme is primary certificate' do
      it 'returns true' do
        programme = build(:primary_certificate)
        expect(programme.primary_certificate?).to be(true)
      end
    end

    context 'when programme is not primary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: nil)
        expect(programme.primary_certificate?).to be(false)
      end
    end
  end

  describe '#cs_accelerator?' do
    context 'when programme is cs accelerator' do
      it 'returns true' do
        programme = build(:cs_accelerator)
        expect(programme.cs_accelerator?).to be(true)
      end
    end

    context 'when programme is not cs accelerator' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme')
        expect(programme.cs_accelerator?).to be(false)
      end
    end
  end

  describe '#secondary_certificate?' do
    context 'when programme is secondary certificate' do
      it 'returns true' do
        programme = build(:secondary_certificate)
        expect(programme.secondary_certificate?).to be(true)
      end
    end

    context 'when programme is not secondary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme')
        expect(programme.secondary_certificate?).to be(false)
      end
    end
  end

  describe '#i_belong?' do
    context 'when programme is an i belong certificate' do
      it 'returns true' do
        programme = build(:i_belong)
        expect(programme.i_belong?).to be(true)
      end
    end

    context 'when programme is not an i belong certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme')
        expect(programme.i_belong?).to be(false)
      end
    end
  end

  describe '#pathways_excluding' do
    it 'returns the pathways except for the pathway argument in order' do
      programme = create(:programme)
      p1 = create(:pathway, programme: programme, order: 10)
      p2 = create(:pathway, programme: programme)
      p3 = create(:pathway, programme: programme, order: 9)

      expect(programme.pathways_excluding(p2)).to eq([p3, p1])
    end

    it 'returns all pathways in order if argument is nil' do
      programme = create(:programme)
      p1 = create(:pathway, programme: programme, order: 3)
      p2 = create(:pathway, programme: programme, order: 1)
      p3 = create(:pathway, programme: programme, order: 2)

      expect(programme.pathways_excluding(nil)).to eq([p2, p3, p1])
    end
  end

  describe '#certificate_name_for_user' do
    it 'should return the user\'s full name' do
      programme = create(:programme)

      expect(programme.certificate_name_for_user(user)).to eq user.full_name
    end
  end

  describe '#public_path' do
    it 'should return nil' do
      programme = create(:programme)

      expect(programme.public_path).to be nil
    end
  end

  describe '#pathways?' do
    it 'should return false' do
      programme = create(:programme)

      expect(programme.pathways?).to be false
    end
  end

  describe '#user_is_eligible?' do
    it 'should return true' do
      programme = create(:programme)
      user = create(:user)

      expect(programme.user_is_eligible?(user)).to be true
    end
  end

  describe '#web_copy' do
    let(:programme) { create(:programme) }

    it 'should be an optional property' do
      programme.web_copy = nil

      expect(programme).to be_valid
    end

    it 'should be a jsonb property' do
      programme.update(web_copy: { 'foo' => 'bar' })

      expect(programme.web_copy).to eq({ 'foo' => 'bar'})
    end
  end

  context 'web copy' do
    let(:programme) { create(:programme) }

    describe '#web_copy_enrichment_intro' do
      it 'should be an store_accessor' do
        intro = 'hello world'
        programme.update(web_copy_enrichment_intro: intro)

        expect(programme.web_copy_enrichment_intro).to eq intro
      end
    end

    describe '#web_copy_enrichment_footer' do
      it 'should be an store_accessor' do
        footer = 'hello world'
        programme.update(web_copy_enrichment_footer: footer)

        expect(programme.web_copy_enrichment_footer).to eq footer
      end
    end
  end

  describe '#enrichment_enabled?' do
    let(:programme) { create(:programme, web_copy_enrichment_intro: intro, web_copy_enrichment_footer: footer) }
    let(:intro) { nil }
    let(:footer) { nil }

    context 'when both enrichment intro and footer are set' do
      let(:intro) { 'intro' }
      let(:footer) { 'footer' }

      it 'returns true' do
        expect(programme.enrichment_enabled?).to be true
      end
    end

    context 'when intro is nil' do
      let(:footer) { 'footer' }

      it 'returns false' do
        expect(programme.enrichment_enabled?).to be false
      end
    end

    context 'when footer is nil' do
      let(:intro) { 'intro' }

      it 'returns false' do
        expect(programme.enrichment_enabled?).to be false
      end
    end
  end
end
