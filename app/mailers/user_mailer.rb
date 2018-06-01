class UserMailer < ApplicationMailer

  default from: "no-reply@Evasmom.com"

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password Reset"
  end

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Eva妈妈"
  end
end
