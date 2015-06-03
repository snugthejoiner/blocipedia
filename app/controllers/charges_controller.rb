class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.username}",
     amount: 100
   }
  end

  def create

    #Amount of charge, in cents
    @amount = 100

    #Creates a Stripe Customer object to associate with charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )
    
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
      )

    flash[:notice] = "Thanks for upgrading to Premium, #{current_user.email}!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end 
end
