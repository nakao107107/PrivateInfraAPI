class Batch::UpdateApplicationCount
  def execute
    Entor.all.each do |entor|
      application_count = Application.where(entor_id: entor.id).count
      entor.application_count = application_count
      entor.save
    end
  end

end