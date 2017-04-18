class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :links

  def self.password_missing?(params)
    params[:user][:password] == ''
  end

  def self.password_confirmation_missing?(params)
    params[:user][:password_confirmation] == ''
  end

  def self.passwords_do_not_match?(params)
    params[:user][:password] != params[:user][:password_confirmation]
  end

  def self.email_missing?(params)
    params[:user][:email] == ''
  end

  def self.both_passwords_missing?(params)
    password_missing? && password_confirmation_missing?
  end

  def self.everything_missing?(params)
    both_passwords_missing? && email_missing?
  end
end
