class Event < ApplicationRecord
  has_many :event_industries
  has_many :industries, through: :event_industries
  has_many :event_occupations
  has_many :occupations, through: :event_occupations
end
