class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
      flash[:notice] = 'You have successfully signed up!'
    else
      error_messages
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def error_messages
    flash[:notice] = "Uh oh, your passwords don't match!" if User.passwords_do_not_match?(params)
    flash[:notice] = "Uh oh, you forgot to enter a password!" if User.password_missing?(params)
    flash[:notice] = "Uh oh, you forgot to enter the password confirmation!" if User.password_confirmation_missing?(params)
    flash[:notice] = "Uh oh, you forgot to enter a password and password confirmation!" if User.both_passwords_missing?(params)
    flash[:notice] = "Uh oh, you forgot to enter an email address!" if User.email_missing?(params)
    flash[:notice] = "Uh oh, you didn't enter any information!" if User.everything_missing?(params)
  end
end
