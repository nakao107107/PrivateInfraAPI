class EntorSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :occupations, :industries, :company_type, :application_count
  def occupations
    object.occupations.pluck(:id)
  end

  def industries
    object.industries.pluck(:id)
  end
end