class Match < ApplicationRecord
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  belongs_to :event
  has_many :messages, dependent: :destroy

end
