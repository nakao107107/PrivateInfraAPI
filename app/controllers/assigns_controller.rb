class AssignsController < ApplicationController
  before_action :check_session

  def create
    Assign.find_or_create_by({event_id: params[:event_id], mentor_id: @mentor.id})
  end

  def destroy
    assign = Assign.find_by({event_id: params[:event_id], mentor_id: @mentor.id})
    assign.delete
  end

end
