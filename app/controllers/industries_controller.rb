class IndustriesController < ApplicationController
  before_action :check_session
  def index
    industries = Industry.all
    render json: industries
  end
end
