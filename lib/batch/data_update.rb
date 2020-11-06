require "google_drive"
require "dotenv"
require 'securerandom'

class Batch::DataUpdate
  def initialize
    # 認証情報を生成する
    credentials = Google::Auth::UserRefreshCredentials.new(
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        refresh_token: ENV['REFRESH_TOKEN']
    )
    @session = GoogleDrive::Session.from_credentials(credentials)
  end

  def execute
    puts "process start"
    puts "mentor update"
    #メンター
    sp = @session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1_XptOWq0ggko9n81yQ1No9FIWKwWFv4ghsUhifJAfF0/edit#gid=1505417215")
    ws = sp.worksheet_by_title("8期メンターヒアリングシート")
    (2..ws.num_rows).each do |row|
      if(ws[row, 1])
        mentor = Mentor.find_or_initialize_by(name: ws[row, 1])
        mentor.id = 'me' + SecureRandom.alphanumeric(10)
        mentor.login_id = "mentor" + (row - 1).to_s
        mentor.password = "password"
        mentor.save
      end
    end
    puts "entor update"
    #エンター
    sp = @session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1_XptOWq0ggko9n81yQ1No9FIWKwWFv4ghsUhifJAfF0/edit#gid=1505417215")
    ws = sp.worksheet_by_title("USER IDデータ")
    (3..ws.num_rows).each do |row|
      entor = Entor.find_or_initialize_by(id: ws[row, 1])
      entor.name = ws[row, 3]
      mentor = Mentor.where(name: ws[row, 10]).first
      entor.mentor_id = mentor ? mentor.id : ''
      entor.save
    end
    puts "event update"
    #イベント
    sp = @session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1jZZEYpx1a4LPf2FZlbC35XeJlHbD6rv9Ml2IczcS3xg/edit#gid=285396842")
    ws = sp.worksheet_by_title("案件DashBoard")
    (2..ws.num_rows).each do |row|
      event = Event.find_or_initialize_by(id: ws[row, 1])
      event.company = ws[row, 2]
      event.name = ws[row, 3]
      event.deadline = ws[row, 4]
      event.save
    end
    #機会創出
    puts "application update"
    sp = @session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1jZZEYpx1a4LPf2FZlbC35XeJlHbD6rv9Ml2IczcS3xg/edit#gid=1951559560")
    ws = sp.worksheet_by_title("application")
    (1..ws.num_rows).each do |row|
      event = Application.find_or_initialize_by(entor_id: ws[row, 1], event_id: ws[row, 3], applicated_at: ws[row, 4])
      event.save
    end
  end

end