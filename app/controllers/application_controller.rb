class ApplicationController < ActionController::API
  def check_session
    access_token = request.headers[:Authorization]
    @mentor = Mentor.where(access_token: access_token).first
  end
end
