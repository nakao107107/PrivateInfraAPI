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

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    event.relate_industries(params[:industries])
    event.relate_occupations(params[:occupations])
    render json: event, serializer: EventSerializer
  end

  def event_params
    params.permit(:id, :name, :hp_url, :slack_url, :deadline, :recommend_text, :company_type, :is_open)
  end
end
