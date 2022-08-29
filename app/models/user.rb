class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tic_tac_toe_games, foreign_key: :cross_player_id
  has_many :tic_tac_toe_games, foreign_key: :circle_player_id
  has_many :sessions, foreign_key: :creator_id
  has_many :sessions, foreign_key: :joiner_id
  has_many :requests, foreign_key: :sender_id
  has_many :messages
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
