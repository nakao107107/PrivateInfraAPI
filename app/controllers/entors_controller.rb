class EntorsController < ApplicationController
  before_action :check_session
  before_action :set_entor, only: [:show, :update]

  def index
    entors = Entor.where(mentor_id: @mentor.id)
    if params[:application_count_less_than]
      entors = entors.where(application_count: 0..params[:application_count_less_than].to_i - 1)
    end
    render json: entors
  end

  def show
    render json: @entor, serializer: EntorSerializer
  end

  def update
    @entor.update!(entor_params)
    @entor.relate_industries(params[:industries])
    @entor.relate_occupations(params[:occupations])
    render json: @entor, serializer: EntorSerializer
  end

  private

  def set_entor
    @entor = Entor.includes([:occupations, :industries]).find(params[:id])
  rescue => e
    render json: {message: 'record not found'}, status: 404
  end

  def entor_params
    params.permit(:nickname, :company_type)
  end

end
