class ApplicationController < ActionController::API
  def check_session
    access_token = request.headers[:Authorization]
    @mentor = Mentor.where(access_token: access_token).first
    #該当メンターがいない場合例外をthrow
    if not @mentor.present?
      render json: {error: "mentor not found"}, status: 400
    end
  end
end
