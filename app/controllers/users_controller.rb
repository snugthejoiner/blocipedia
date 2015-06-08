class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
      if @user.update_attributes(params.require(:user).permit(:username))
      flash[:notice] = "Your changes have been saved."
      redirect_to @user
    else
      flash[:error] = "There was an error updating your account"
    end
  end

  def show
    @user = current_user
  end

  def downgrade
    @user = current_user
    @user.update_attribute(:role, 'standard')
    customer = Stripe::Customer.retrieve(@user.stripe_id)
    Stripe::Customer.retrieve(@user.stripe_id).subscriptions.first.delete
    # customer.subscriptions.retrieve({SUBSCRIPTION_ID}).delete
    if @user.save
      flash[:notice] = "You now have a standard account and will no longer be charged your monthly subscription."
      redirect_to @user
    else
      flash[:error] = "There was an error updating your account"
    end
  end

end
