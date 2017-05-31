class Decision < ApplicationRecord
  belongs_to :event
  belongs_to :decision_maker, class_name: 'User'
  belongs_to :decision_receiver, class_name: 'User'
end
