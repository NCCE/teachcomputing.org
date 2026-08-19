class MakeUserStemUserIdNullableOnUserReportEntries < ActiveRecord::Migration[8.1]
  def change
    change_column_null :user_report_entries, :user_stem_user_id, true
  end
end
