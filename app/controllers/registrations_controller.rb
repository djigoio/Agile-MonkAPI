class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.save
      render json: { status: 'OK', message: 'User registered', data: resource }, status: :created
    else
      render json: { status: 'ERROR', message: 'User NOT registered', data: resource.errors }, status: :unprocessable_entity
    end
  end
end
