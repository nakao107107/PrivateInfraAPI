class EntorSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :occupations, :industries
  def occupations
    object.occupations.pluck(:id)
  end

  def industries
    object.industries.pluck(:id)
  end
end