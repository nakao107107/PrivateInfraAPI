class EventsController < ApplicationController
  def index
    events = Event.where("deadline >= ?", Time.current)
    render json: events
  end

  def show
    event = Event.find(params[:id])
    render json: event
  rescue => e
    render json: {message: 'record not found'}, status: 404
  end

  def progress
    event_ids = Event.all.pluck(:id)
    progress_event_ids = Progress.where(status: 'IN_PROGRESS').pluck(:event_id)
    done_event_ids = Progress.where(status: 'DONE').pluck(:event_id)
    new_event_ids = event_ids - (progress_event_ids + done_event_ids)

    progress = {
        new: Event.where(id: new_event_ids),
        progress: Event.where(id: progress_event_ids),
        done: Event.where(id: done_event_ids)
    }

    render json: progress
  end

  def update_progress

  end
end
