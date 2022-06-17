class AddBookingProgrammeSlugFieldToActivityModel < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :booking_programme_slug, :string, null: true
  end
end
