class IndustriesController < ApplicationController
  def index
    industries = Industry.all
    render json: industries
  end
end
