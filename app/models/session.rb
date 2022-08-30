class Session < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :joiner, class_name: "User"
  has_many :game_matches
  has_many :requests
  has_many :messages
end
