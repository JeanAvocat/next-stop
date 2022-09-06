class Message < ApplicationRecord
  belongs_to :trip_session
  belongs_to :user

  validates :content, presence: true

  # method to define the user is the current user or not
  def sender?(a_user)
    user.id == a_user.id
  end
end
