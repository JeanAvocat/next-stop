class Request < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :session

  STATUS = ["Accepted", "Refused", "Pending"]
  validates :status, inclusion: { in: STATUS, message: "doit correspondre à la liste déroulante" }
  validates :status, presence: true
end
