class Message < ApplicationRecord
  belongs_to :match
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :content, :match_id, :sender_id, :recipient_id
end

