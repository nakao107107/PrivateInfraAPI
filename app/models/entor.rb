class Entor < ApplicationRecord
  has_many :entor_industries
  has_many :industries, through: :entor_industries
  has_many :entor_occupations
  has_many :occupations, through: :entor_occupations

  def relate_industries(industry_ids)
    industries.delete_all
    entor_industries = []
    industry_ids.each do |industry_id|
      entor_industries << EntorIndustry.new(
          {entor_id: id, industry_id: industry_id}
      )
    end
    EntorIndustry.import entor_industries
  end

  def relate_occupations(occupation_ids)
    occupations.delete_all
    entor_occupations = []
    occupation_ids.each do |occupation_id|
      entor_occupations << EntorOccupation.new(
          {entor_id: id, occupation_id: occupation_id}
      )
    end
    EntorOccupation.import entor_occupations
  end
end