require 'rails_helper'

RSpec.describe User do
  let(:stem_credentials) do
    OmniAuth::AuthHash.new(expires: true,
                           expires_at: Time.zone.now.to_i,
                           refresh_token: '7bf7e7c2eb515fbc5ba4d2f7b3e8bn',
                           token: 'cd355fc7dccd9c7bb7e2c29f4be3f')
  end
  let(:stem_info) do
    OmniAuth::AuthHash::InfoHash.new(
      achiever_contact_no: 'ca432eb9-9b34-46db-afbb-fbd1efa89e6b',
      email: 'user@example.com',
      first_name: 'Jane',
      last_name: 'Doe'
    )
  end
  let(:uid) { 'id-stem-user' }
  let(:user) { described_class.from_auth(uid, stem_credentials, stem_info) }

  describe 'validations' do
    before do
      user
    end

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:stem_achiever_contact_no) }
    it { is_expected.to validate_presence_of(:stem_credentials_access_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_refresh_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_expires_at) }
    it { is_expected.to validate_presence_of(:stem_user_id) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:stem_user_id) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:teacher_reference_number) }
  end

  describe 'defaults' do
    it 'sets forgotten to false by default' do
      expect(user.forgotten).to be false
    end
  end

  describe 'encryption' do
    it 'encrypts stem_credentials_access_token' do
      expect(user.stem_credentials_access_token).not_to be_nil
      expect(user.encrypted_stem_credentials_access_token).not_to eq user.stem_credentials_access_token
    end

    it 'encrypts stem_credentials_refresh_token' do
      expect(user.stem_credentials_refresh_token).not_to be_nil
      expect(user.encrypted_stem_credentials_refresh_token).not_to eq user.stem_credentials_refresh_token
    end
  end

  describe 'associations' do
    it 'has_many achievements' do
      expect(user).to have_many(:achievements)
    end

    it 'has_many activities through achievements' do
      expect(user).to have_many(:activities).through(:achievements)
    end

    it 'has_many programmes through achievements' do
      expect(user).to have_many(:programmes).through(:user_programme_enrolments)
    end

    it 'has_many resource_users' do
      expect(user).to have_many(:resource_users)
    end

    it 'has_many questionnaire_responses' do
      expect(user).to have_many(:questionnaire_response)
    end

    it 'has_many feedback_comments' do
      expect(user).to have_many(:feedback_comments)
    end
  end

  describe 'after_create' do
    it 'schedules FetchUsersCompletedCoursesFromAchieverJob' do
      user = build(:user)
      expect do
        user.save
      end.to have_enqueued_job(Achiever::FetchUsersCompletedCoursesFromAchieverJob)
    end
  end

  describe '#from_auth' do
    it 'has the correct id' do
      expect(user.stem_user_id).to eq 'id-stem-user'
    end

    it 'has the correct first name' do
      expect(user.first_name).to eq 'Jane'
    end

    it 'has the correct last name' do
      expect(user.last_name).to eq 'Doe'
    end

    it 'has the correct email' do
      expect(user.email).to eq 'user@example.com'
    end

    it 'has the correct achiver contact number' do
      expect(user.stem_achiever_contact_no).to eq 'ca432eb9-9b34-46db-afbb-fbd1efa89e6b'
    end

    it 'has the correct token' do
      expect(user.stem_credentials_access_token).to eq 'cd355fc7dccd9c7bb7e2c29f4be3f'
    end

    it 'has the correct refresh token' do
      expect(user.stem_credentials_refresh_token).to eq '7bf7e7c2eb515fbc5ba4d2f7b3e8bn'
    end

    it 'has the correct expires at' do
      expect(user.stem_credentials_expires_at).to be_today
    end

    it 'has the last sign in date set' do
      expect(user.last_sign_in_at).to be_today
    end
  end

  describe '#enrolments' do
    it 'returns UserProgrammeEnrolments for the given user' do
      enrolment = create(:user_programme_enrolment, user_id: user.id)
      expect(user.enrolments).to include enrolment
    end
  end

  describe '#csa_auto_enrollable?' do
    context 'when user is enrolled on CSA programme' do
      let!(:enrolment) do
        create(:user_programme_enrolment, user:, programme: create(:cs_accelerator))
      end

      it 'returns false' do
        expect(user.csa_auto_enrollable?).to be false
      end

      context 'when user has unenrolled' do
        it 'returns false' do
          enrolment.transition_to(:unenrolled)
          expect(user.csa_auto_enrollable?).to be false
        end
      end

      context 'when user has completed' do
        it 'returns false' do
          enrolment.transition_to(:complete)
          expect(user.csa_auto_enrollable?).to be false
        end
      end

      context 'when user enrolment is in pending state' do
        it 'returns false' do
          enrolment.transition_to(:pending)
          expect(user.csa_auto_enrollable?).to be false
        end
      end
    end

    context 'when user is not enrolled on CSA programme' do
      it 'returns true' do
        expect(user.csa_auto_enrollable?).to be true
      end
    end
  end

  describe '#programme_enrolment_state' do
    context 'when user is enrolled to the programme' do
      it 'returns programme enrolment state' do
        programme = create(:programme)
        create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id)
        expect(user.programme_enrolment_state(programme.id)).to eq 'enrolled'
      end
    end

    context 'when user is not enrolled to the programme' do
      it 'returns not enrolled' do
        programme = create(:programme)
        expect(user.programme_enrolment_state(programme.id)).to eq 'Not enrolled'
      end
    end
  end

  describe '#on_programme_pathway?' do
    let(:programme) { create(:cs_accelerator) }

    it 'returns false when user not enrolled' do
      expect(user.on_programme_pathway?(programme)).to be false
    end

    it 'returns false when user is not on a pathway for that programme' do
      create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id)
      expect(user.on_programme_pathway?(programme)).to be false
    end

    it 'returns true when user is on a pathway for that programme' do
      pathway = create(:pathway, programme:)
      create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id, pathway_id: pathway.id)
      expect(user.on_programme_pathway?(programme)).to be true
    end
  end

  describe '#programme_pathway' do
    let(:programme) { create(:cs_accelerator) }

    it 'returns nil when user not enrolled' do
      expect(user.programme_pathway(programme)).to be_nil
    end

    it 'returns nil when user is not on a pathway for that programme' do
      create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id, pathway: nil)
      expect(user.programme_pathway(programme)).to be_nil
    end

    it 'returns pathway when user is on a pathway for that programme' do
      pathway = create(:pathway, programme:)
      create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id, pathway_id: pathway.id)
      expect(user.programme_pathway(programme)).not_to be_nil
      expect(user.programme_pathway(programme)).to eq(pathway)
    end
  end

  describe '#enrolled_on_programme_pathway?' do
    let(:programme) { create(:programme) }
    let(:pathway) { create(:pathway) }

    context 'when the user is enrolled' do
      let!(:user_programme_enrolemnt) { create(:user_programme_enrolment, programme:, pathway:, user:) }
      it 'should return true' do
        expect(user.enrolled_on_programme_pathway?(programme:, pathway:)).to be true
      end
    end

    context 'when the user is not enrolled' do
      it 'should return true' do
        expect(user.enrolled_on_programme_pathway?(programme:, pathway:)).to be false
      end
    end
  end
end
