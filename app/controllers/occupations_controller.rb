class OccupationsController < ApplicationController
  before_action :check_session
  def index
    occupations = Occupation.all
    render json: occupations
  end
end
