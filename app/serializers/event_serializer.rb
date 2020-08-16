class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :hp_url, :slack_url, :recommend_text, :deadline, :occupations, :industries
  def occupations
    object.occupations.pluck(:id)
  end

  def industries
    object.industries.pluck(:id)
  end
end