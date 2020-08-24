class Event < ApplicationRecord
  has_many :event_industries
  has_many :industries, through: :event_industries
  has_many :event_occupations
  has_many :occupations, through: :event_occupations

  def relate_industries(industry_ids)
    industries.delete_all
    event_industries = []
    industry_ids.each do |industry_id|
      event_industries << EventIndustry.new(
          {event_id: id, industry_id: industry_id}
      )
    end
    EventIndustry.import event_industries
  end

  def relate_occupations(occupation_ids)
    occupations.delete_all
    event_occupations = []
    occupation_ids.each do |occupation_id|
      event_occupations << EventOccupation.new(
          {event_id: id, occupation_id: occupation_id}
      )
    end
    EventOccupation.import event_occupations
  end
end
