class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :links

  def password_missing?(params)
    params[:user][:password] == ''
  end

  def password_confirmation_missing?(params)
    params[:user][:password_confirmation] == ''
  end

  def passwords_do_not_match?(params)
    params[:user][:password] != params[:user][:password_confirmation]
  end

  def email_missing?(params)
    params[:user][:email] == ''
  end

  def both_passwords_missing?(params)
    password_missing? && password_confirmation_missing?
  end

  def everything_missing?(params)
    both_passwords_missing? && email_missing?
  end
end
