class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :trip_sessions_as_creator, foreign_key: :creator_id, class_name: "TripSession"
  has_many :trip_sessions_as_joiner, foreign_key: :joiner_id, class_name: "TripSession"

  has_many :tic_tac_toe_games_as_cross_player, foreign_key: :cross_player_id, class_name: "TicTacToeGame"
  has_many :tic_tac_toe_games_as_circle_player, foreign_key: :circle_player_id, class_name: "TicTacToeGame"

  has_many :chifoumi_games_as_first_player, foreign_key: :first_player_id, class_name: "Chifoumi"
  has_many :chifoumi_games_as_second_player, foreign_key: :second_player_id, class_name: "Chifoumi"

  has_one_attached :user_photo


  MALE_NAME = ["Cactus", "Saucisson", "Biscuit", "Buisson", "Nuage", "Soleil", "Coeur", "Chaton", "Doudou", "Bébé", "Gnome", "Dindon"]
  MALE_ADJECTIVE = ["Doux", "Tendre", "Beau", "Piquant", "Brillant", "Douillet", "Petit", "Gros", "Soyeux", "Vilain", "Poli", "Enflammé", "Moux", "Honnête", "Audacieux", "Habile", "Costaud", "Irrésistible", "Simplet", "Gentil", "Sexy", "Coquet", "Rusé", "Bougre", "Forceur"]

  FEMALE_NAME = ["Craquotte", "Aubergine", "Saucisse", "Guimauve", "Princesse", "Compote", "Licorne", "Paillette"]
  FEMALE_ADJECTIVE = ["Douce", "Tendre", "Belle", "Piquante", "Brillante", "Douillette", "Petite", "Grosse", "Soyeuse", "Vilaine", "Polie", "Fofolle", "Enflammée", "Molle", "Honnête", "Audacieuse", "Habile", "Irrésistible", "Gentille", "Sexy", "Coquette", "Rusée"]

  def set_nickname
    male_or_femmale = rand(0..1) == 1 ? "MALE" : "FEMALE"
    "User::#{male_or_femmale}_ADJECTIVE".constantize.sample + " " + "User::#{male_or_femmale}_NAME".constantize.sample
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :email, presence: true
end
