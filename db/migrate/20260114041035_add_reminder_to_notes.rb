class AddReminderToNotes < ActiveRecord::Migration[8.1]
  def change
    add_column :notes, :reminder_at, :datetime
    add_column :notes, :reminder_enabled, :boolean
  end
end
