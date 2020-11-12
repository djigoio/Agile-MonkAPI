module Api
  module V1
    class CustomersController < ApplicationController

      def index
        customers = Customer.all
        successful_response('All customers loaded', customers)
      end

      def show
        customer = Customer.find(params[:id])
        successful_response('Customer shown', customer)
      end

      def create
        customer = Customer.new(customer_params)
        #TODO add created  by user
        if customer.save
          successful_response('Customer created', customer)
        else
          erroneous_response('Customer could not be created', customer)
        end
      end
      
      def update
        customer = Customer.find(params[:id])

        if customer.update_attributes(customer_params)
          successful_response('Customer updated', customer)
        else
          erroneous_response('Customer updated', customer)
        end
      end
      
      def destroy
        customer = Customer.find(params[:id])
        if customer.destroy
          successful_response('Customer was deleted', customer)
        else 
          erroneous_response('Customer was NOT deleted', customer)
        end
      end

      private

      def customer_params
        params.permit(:name, :surname)
      end

      def successful_response(message, data)
        render json: {status: 'OK', message: message, data: data}, status: :ok
      end

      def erroneous_response(message, data)
        render json: {status: 'ERROR', message: message, data: data.errors}, status: :unprocessable_entity
      end
    end
  end
end