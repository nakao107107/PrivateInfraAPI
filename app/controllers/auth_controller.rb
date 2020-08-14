class AuthController < ApplicationController

  def login
    #login_idにあてはまるユーザーをチェック
    mentor = Mentor.where(login_id: login_params[:login_id]).first
    if(mentor && mentor.authenticate(login_params[:password]))
      mentor.login
      render json: {access_token: mentor.access_token}
    else
      throw new Exception('login failed')
    end
  rescue => e
    p e
    render json: {error: 'login failed'}, status: 400
  end

  def login_params
    params.permit(:login_id, :password)
  end

end
