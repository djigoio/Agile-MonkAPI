class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: session_params[:email])
    if user&.valid_password?(session_params[:password])
      sign_in user
      session = { token: current_token }
      render json: {status: 'OK', message: 'Login completed', data: session}, status: :ok
    else
      render json: {status: 'Error', message: 'Invalid user/password ', data: session}, status: :unprocessable_entity
    end
  end

private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def respond_to_on_destroy
    head :unauthorized
  end
end