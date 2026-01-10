class AddArchivedToNotes < ActiveRecord::Migration[8.1]
  def change
    add_column :notes, :archived, :boolean, default: false
  end
end
