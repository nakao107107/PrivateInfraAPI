require_relative '../../lib/http.rb'
class EventsController < ApplicationController
  def index
    events = Event.includes([:industries, :occupations]).where("deadline >= ?", Time.current)
    if params[:publish]
      events = events.where(is_open: true)
    end
    render json: events, each_serializer: EventSerializer
  end

  def show
    event = Event.includes([:industries, :occupations]).find(params[:id])
    render json: event, serializer: EventSerializer
  rescue => e
    render json: {message: 'record not found'}, status: 404
  end

  def post_to_slack
    event = Event.includes([:industries, :occupations]).find(params[:event_id])
    http = Http.new(ENV['SLACK_URL'])
    #eventデータからtext作成
    text = "<!channel>\n新着案件告知です!\n\n*<#{event.hp_url}/|#{event.name}>*"
    industries = event.industries
    industries_array = industries.map{|industry| industry.name}
    text = text + "\n\n*業界*: #{industries_array.join(', ')}"
    text = text + "\n*締め切り*: #{Date.parse(event.deadline.to_s).strftime('%m/%d')}"
    text = text + "\n*その他情報*: \n#{event.note}"
    text = text + "\n*LINE文言例*: ```#{event.recommend_text.gsub("{@エンター名}","〇〇")}```"
    text = text + "\n\n自分のエンターとの相性をチェック\nhttp://encourage.lei-wa.link/events/#{event.id}"
    body = {text: text}
    res = http.post('', body.to_json)
    puts res[:body]
  rescue => e
    puts e
    render json: {message: 'failed to post to slack'}, status: 404
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
    #slackへの投稿
    render json: event, serializer: EventSerializer
  end

  def event_params
    params.permit(:id, :name, :hp_url, :slack_url, :deadline, :recommend_text, :company_type, :is_open, :note)
  end
end
