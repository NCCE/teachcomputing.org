class AddConceptOfCertificateDetails < ActiveRecord::Migration[6.1]
  def up
    add_column :user_programme_enrolments, :complete_certificate_metadata, :jsonb, default: {}

    UserProgrammeEnrolment.in_state(:complete).where(programme: Programme.i_belong).includes(:user).find_each do |upe|
      upe.update(complete_certificate_metadata: { certificate_name: upe.user.school_name })
    end

    UserProgrammeEnrolment.in_state(:complete).where.not(programme: Programme.i_belong).includes(:user).find_each do |upe|
      upe.update(complete_certificate_metadata: { certificate_name: upe.user.full_name })
    end

    User.update_all(school_name: nil)
  end

  def down
    remove_column :user_programme_enrolments, :complete_certificate_metadata
  end
end
