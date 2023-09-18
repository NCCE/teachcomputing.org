require 'rails_helper'

RSpec.describe 'rake migrate_old_primary_pathways', type: :task do
  let(:old_developing) { create(:pathway, slug: 'developing-in-the-classroom') }
  let(:new_developing) { create(:pathway, slug: 'developing-in-the-classroom-2') }
  let(:old_specialising) { create(:pathway, slug: 'specialising-or-leading') }
  let(:new_specialising) { create(:pathway, slug: 'specialising-or-leading-2') }

  let!(:upe_old_developing) { create(:user_programme_enrolment, pathway: old_developing) }
  let!(:upe_new_developing) { create(:user_programme_enrolment, pathway: new_developing) }
  let!(:upe_old_specialising) { create(:user_programme_enrolment, pathway: old_specialising) }
  let!(:upe_new_specialising) { create(:user_programme_enrolment, pathway: new_specialising) }

  it 'should set the upe old developing to have the new developing pathway' do
    task.execute

    expect(upe_old_developing.reload.pathway).to eq new_developing
  end

  it 'should set the upe old developing to have the message_flags_pathway_migrated flag' do
    task.execute

    expect(upe_old_developing.reload.message_flags_primary_pathway_migrated).to be true
  end

  it 'should not change the new developing upe' do
    task.execute

    expect(upe_new_developing.reload.pathway).to eq new_developing
    expect(upe_new_developing.message_flags_primary_pathway_migrated).to be nil
  end

  it 'should set the upe old specialising to have the new specialising pathway' do
    task.execute

    expect(upe_old_specialising.reload.pathway).to eq new_specialising
  end

  it 'should set the upe old specialising to have the message_flags_pathway_migrated flag' do
    task.execute

    expect(upe_old_specialising.reload.message_flags_primary_pathway_migrated).to be true
  end

  it 'should not change the new specialising upe' do
    task.execute

    expect(upe_new_specialising.reload.pathway).to eq new_specialising
    expect(upe_new_specialising.message_flags_primary_pathway_migrated).to be nil
  end
end
