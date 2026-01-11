class Note < ApplicationRecord
  belongs_to :user

  has_many :note_shares, dependent: :destroy
  has_many :shared_users, through: :note_shares, source: :user

  scope :active, -> { where(archived: [false, nil]) }
  scope :archived, -> { where(archived: true) }
  scope :favorites, -> { where(favorite: true) }

  before_update :unfavorite_if_archived

  validates :title, presence: true
  validates :description, presence: true

  private

  def unfavorite_if_archived
    if archived_changed?(from: false, to: true)
      self.favorite = false
    end
  end
end
