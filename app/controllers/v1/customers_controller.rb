class V1::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]
  before_action :set_last_updated_by, only: :update
  
  def index
    customers = Customer.all
    render json: {status: 'OK', message: 'All customers loaded', data: customers}, status: :ok
  end

  def show
    customer = { avatar_url: url_for(@customer.avatar), record: @customer }
    render json: {status: 'OK', message: 'Customer shown', data: @customer}, status: :ok
  end

  def create
    @customer = Customer.create(customer_params)
    attach_avatar_to_customer if params[:avatar].present?
    customer.update_attribute(:created_by, current_user.id)
    render json: {status: 'OK', message: 'Customer created', data: @customer}, status: :created
  end
      
  def update
    attach_avatar_to_customer if params[:avatar].present?
    if @customer.update_attributes(customer_params)
      render json: {status: 'OK', message: 'Customer updated', data: @customer}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Customer NOT updated', data: @customer.errors}, status: :unprocessable_entity
    end
  end
      
  def destroy
    if @customer.destroy
      render json: {status: 'OK', message: 'Customer deleted', data: @customer}, status: :ok
    else 
      render json: {status: 'ERROR', message: 'Customer NOT deleted', data: @customer.errors}, status: :unprocessable_entity
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
    params.permit(:avatar, :name, :surname)
  end

  def attach_avatar_to_customer
    @customer.avatar.attach(params[:avatar]) 
  end
end