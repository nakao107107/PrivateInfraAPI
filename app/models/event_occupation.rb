class EventOccupation < ApplicationRecord
  belongs_to :event
  belongs_to :occupation
end