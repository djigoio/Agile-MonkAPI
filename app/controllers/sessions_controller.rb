class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /login
  def create
    user = User.find_by(email: login_params[:email])
    if user&.valid_password?(login_params[:password])
      sign_in user
      render json: {status: 'OK', message: 'Login completed', data: session}, status: :ok
    else
      render json: {status: 'Error', message: 'Invalid user/password ', data: session}, status: :unprocessable_entity
    end
  end

  private

  def respond_to_on_destroy
      head :ok
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
