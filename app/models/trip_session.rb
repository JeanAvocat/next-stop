class TripSession < ApplicationRecord
  belongs_to :creator, foreign_key: :creator_id, class_name: "User"
  belongs_to :joiner, foreign_key: :joiner_id, class_name: "User", optional: true
  has_many :game_matches
  has_many :requests
  has_many :messages

  STATUS = ["waiting for joiner", "in game", "closed"]

  validates :status, presence: true, inclusion: { in: STATUS }

end
