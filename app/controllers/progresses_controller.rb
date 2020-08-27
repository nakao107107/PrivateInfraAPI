class ProgressesController < ApplicationController
  before_action :check_session
  def show
    event_ids = Event.all.pluck(:id)
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

  def update
    progress = Progress.find_or_initialize_by(
        {
            event_id: progress_params[:event_id],
            mentor_id: @mentor.id
        }
    )
    progress.status = progress_params[:status]
    progress.save!
  end

  private
  def progress_params
    params.permit(:event_id, :status)
  end
end
