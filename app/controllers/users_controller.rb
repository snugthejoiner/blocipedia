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
    if @user.save
      flash[:notice] = "You now have a standard account."
      redirect_to @user
    else
      flash[:error] = "There was an error updating your account"
    end
  end

end
