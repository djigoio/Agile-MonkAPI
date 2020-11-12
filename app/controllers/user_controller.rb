class UserController < ApplicationController
    before_action :authenticate_admin
    before_action :set_user, only: [:show, :update, :destroy]

    def index
      @users = User.all
      json_response(@users)
    end

    def create
      @user = User.create!(user_params)
      json_response(@user)
    end

    def show
      json_response(@user)
    end

    def update
      @user.update!(user_params)
      json_response('The user has been updated', 200)
    end

    def destroy
      @user.destroy!
      json_response( 'The user has been deleted from the database', 200)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end    
end
