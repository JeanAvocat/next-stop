class GameMatch < ApplicationRecord
  belongs_to :matchable, polymorphic: true
  belongs_to :session
end
