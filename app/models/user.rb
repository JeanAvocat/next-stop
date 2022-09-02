class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :trip_sessions, foreign_key: :creator_id
  has_many :trip_sessions, foreign_key: :joiner_id

  has_many :tic_tac_toe_games, foreign_key: :cross_player_id
  has_many :tic_tac_toe_games, foreign_key: :circle_player_id

  has_one_attached :user_photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :email, :password, presence: true
end
