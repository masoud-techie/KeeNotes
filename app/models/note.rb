class Note < ApplicationRecord
  belongs_to :user

  has_many :note_shares, dependent: :destroy
  has_many :shared_users, through: :note_shares, source: :user

  # 🔹 Exclude deleted notes by default
  default_scope { where(deleted_at: nil) }

  # 🔹 Existing scopes (unchanged behavior)
  scope :active,    -> { where(archived: [false, nil]) }
  scope :archived,  -> { where(archived: true) }
  scope :favorites, -> { where(favorite: true) }

  # 🔹 Recycle bin scope
  scope :deleted, -> {
    unscoped.where.not(deleted_at: nil)
  }

  before_update :unfavorite_if_archived

  validates :title, presence: true
  validates :description, presence: true

  # 🔹 Soft delete methods
  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end

  private

  def unfavorite_if_archived
    if archived_changed?(from: false, to: true)
      self.favorite = false
    end
  end
end
