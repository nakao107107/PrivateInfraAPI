class OccupationsController < ApplicationController
  def index
    occupations = Occupation.all
    render json: occupations
  end
end
