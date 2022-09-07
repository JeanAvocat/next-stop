class TripSession < ApplicationRecord
  belongs_to :creator, foreign_key: :creator_id, class_name: "User"
  belongs_to :joiner, foreign_key: :joiner_id, class_name: "User", optional: true
  has_many :game_matches
  has_many :requests
  has_many :messages

  STATUS = ["waiting for joiner", "in game", "closed"]

  validates :status, presence: true, inclusion: { in: STATUS }

  def joiner_or_creatore
    # method to define who is cross player or circle player in order to randomize the first plyer who start
    rand(0..1) == 1 ? ["creator", "joiner"] : ["joiner", "creator"]
  end

end
