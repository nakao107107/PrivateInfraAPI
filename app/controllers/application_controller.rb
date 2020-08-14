class ApplicationController < ActionController::API
  def check_session
    access_token = request.headers[:Authorization]
    @mentor = Mentor.where(access_token: access_token).first
  rescue StandardError => e
    render json: { error: e.message }, status: 401
  end
end
