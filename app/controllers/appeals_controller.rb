class AppealsController < ApplicationController
  before_action :check_session

  def index
    appeals = Appeal.where(mentor_id: @mentor.id)
    render json: appeals
  end

  def create
    appeal = Appeal.find_or_create_by(
        {
            mentor_id: @mentor.id,
            event_id: params[:event_id],
            entor_id: params[:entor_id],
        }
    )
    appeal.save
  end

  def destroy
    appeal = Appeal.find_or_create_by(
        {
            mentor_id: @mentor.id,
            event_id: params[:event_id],
            entor_id: params[:entor_id],
        }
    )
    appeal.delete
  end
end
