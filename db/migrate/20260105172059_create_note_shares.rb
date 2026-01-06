class CreateNoteShares < ActiveRecord::Migration[7.1]
  def change
    create_table :note_shares do |t|
      t.references :note, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :note_shares, [:note_id, :user_id], unique: true
  end
end
