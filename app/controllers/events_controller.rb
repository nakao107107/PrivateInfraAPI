class EventsController < ApplicationController
  def index
    events = Event.includes([:industries, :occupations]).where("deadline >= ?", Time.current)
    render json: events, each_serializer: EventSerializer
  end

  def show
    event = Event.includes([:industries, :occupations]).find(params[:id])
    render json: event, serializer: EventSerializer
  rescue => e
    render json: {message: 'record not found'}, status: 404
  end

  def create
    event = Event.create!(event_params)
    event.relate_industries(params[:industries])
    event.relate_occupations(params[:occupations])
    render json: event, serializer: EventSerializer
  end

  def progress
    event_ids = Event.where("deadline >= ?", Time.current).all.pluck(:id)
    progress_event_ids = Progress.where(mentor_id: @mentor.id).where(status: 'IN_PROGRESS').pluck(:event_id)
    done_event_ids = Progress.where(mentor_id: @mentor.id).where(status: 'DONE').pluck(:event_id)
    new_event_ids = event_ids - (progress_event_ids + done_event_ids)

    progress = {
        new: Event.where(id: new_event_ids),
        progress: Event.where(id: progress_event_ids),
        done: Event.where(id: done_event_ids)
    }

    render json: progress
  end

  def event_params
    params.permit(:id, :name, :hp_url, :slack_url, :deadline, :recommend_text, :company_type)
  end
end
