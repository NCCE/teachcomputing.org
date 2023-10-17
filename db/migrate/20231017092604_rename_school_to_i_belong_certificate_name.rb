class RenameSchoolToIBelongCertificateName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :school_name, :i_belong_certificate_name
  end
end
