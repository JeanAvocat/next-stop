class Message < ApplicationRecord
  belongs_to :trip_session
  belongs_to :user
end
