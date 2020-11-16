class RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    # POST /signup
    def create
      build_resource(sign_up_params)
      if resource.save
        render json: {status: 'OK', message: 'Registration complete', data: resource}, status: :created
      else
        render json: {status: 'ERROR', message: 'Registration NOT completed', data: resource.errors}, status: :unprocessable_entity
      end
    end
  
    private
  
    def sign_up_params
      params.require(:user).permit(:email, :password)
    end
  end
  