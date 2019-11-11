class Todo < ApplicationRecord
  belongs_to :user

  validates :user_id, :description, :schedule, presence: true
end
