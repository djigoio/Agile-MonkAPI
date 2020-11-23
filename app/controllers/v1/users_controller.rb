class V1::UsersController < ApplicationController
  before_action :auth_admin
  before_action :set_user, only: %i[destroy show update]

  def index
    @users = User.all
    render json: { status: 'OK', message: 'Users listed', data: @users }, status: :ok
  end

  def create
    @user = User.create!(user_params)
    render json: { status: 'OK', message: 'User generated', data: @user }, status: :created
  end

  def show
    render json: { status: 'OK', message: 'User shown', data: @user }, status: :ok
  end

  def update
    @user.update!(user_params)
    render json: { status: 'OK', message: 'User updated', data: @user }, status: :ok
  end

  def destroy
    @user.destroy!
    render json: { status: 'OK', message: 'User deleted', data: @user }, status: :ok
  end

  private

  def user_params
    params.permit(:email, :password, :is_admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def auth_admin
    unless current_user.is_admin?
      render json: { status: 'UNAUTHORIZED', message: 'You do not have permissions to perform that action', data: @user }, status: :unauthorized
    end
  end
end
