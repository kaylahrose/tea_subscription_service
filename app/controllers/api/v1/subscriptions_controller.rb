class Api::V1::SubscriptionsController < ApplicationController
  def create
    new_sub = Subscription.create(create_sub_params) 
    render json: SubscriptionSerializer.new(new_sub), status: :created
  end

  def update
    sub = Subscription.find(params[:id])
    sub.update(status: 1)
    render json: SubscriptionSerializer.new(sub)
  end

  private

  def create_sub_params
    params.permit(:customer_id, :tea_id, :frequency, :price)
  end
end