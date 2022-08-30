class GameMatch < ApplicationRecord
  belongs_to :matchable, polymorphic: true
  belongs_to :trip_session
end
