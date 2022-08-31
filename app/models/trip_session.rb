class TripSession < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :joiner, class_name: "User"
  has_many :game_matches
  has_many :requests
  has_many :messages

  STATUS = ["waiting for joiner", "in game", "closed"]
  validates :status, presence: true, inclusion: { in: STATUS }

  def available_for_joiner?
    status == "Waiting for joiner"
  end
end
