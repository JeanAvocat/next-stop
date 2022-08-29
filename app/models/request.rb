class Request < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :session
end
