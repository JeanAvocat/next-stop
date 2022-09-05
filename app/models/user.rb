class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :trip_sessions_as_creator, foreign_key: :creator_id, class_name: "TripSession"
  has_many :trip_sessions_as_joiner, foreign_key: :joiner_id, class_name: "TripSession"

  has_many :tic_tac_toe_games_as_cross_player, foreign_key: :cross_player_id, class_name: "TicTacToeGame"
  has_many :tic_tac_toe_games_as_circle_player, foreign_key: :circle_player_id, class_name: "TicTacToeGame"

  has_one_attached :user_photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :email, :password, presence: true
end
