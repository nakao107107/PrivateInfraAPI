class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :company, :company_type, :hp_url, :slack_url, :recommend_text, :deadline, :occupations, :industries, :is_open, :note
  def occupations
    object.occupations.pluck(:id)
  end

  def industries
    object.industries.pluck(:id)
  end
end