class V1::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]
  # before_action :set_last_updated_by, only: :update
  # TODO Fix this callback
  # TODO current_user not being set
  
  def index
    customers = Customer.all
    successful_response('All customers loaded', customers)
  end

  def show
    customer = { avatar_url: url_for(@customer.avatar), record: @customer }
    successful_response('Customer shown', @customer)
  end

  def create
    #TODO Allow avatar to customer_params
    @customer = Customer.create(customer_params)
    attach_avatar_to_customer if params[:avatar].present?
    #TODO Avatar param not working with value
    #customer.update_attribute(:created_by, current_user.id)
    successful_response('Customer created', @customer)
  end
      
  def update
    attach_avatar_to_customer if params[:avatar].present?
  if @customer.update_attributes(customer_params)
      successful_response('Customer updated', @customer)
    else
      erroneous_response('Customer updated', @customer)
    end
  end
      
  def destroy
    if @customer.destroy
      successful_response('Customer was deleted', @customer)
    else 
      erroneous_response('Customer was NOT deleted', @customer)
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])  
  end

  def set_last_updated_by
    @customer.update_attribute(:last_update_by, current_user.id)
  end

  def customer_params
    params.require(:customer).permit(:avatar, :name, :surname)
  end

  def attach_avatar_to_customer
    @customer.avatar.attach(params[:avatar]) 
  end

  def successful_response(message, data)
    render json: {status: 'OK', message: message, data: data}, status: :ok
  end

  def erroneous_response(message, data)
    render json: {status: 'ERROR', message: message, data: data.errors}, status: :unprocessable_entity
  end

end