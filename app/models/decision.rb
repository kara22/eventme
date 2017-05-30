class Decision < ApplicationRecord
  belongs_to :event
  belongs_to :decision_maker_id, class_name: 'User'
  belongs_to :decision_receiver_id, class_name: 'User'
end
