class UserMailer < ApplicationMailer

  default from: "no-reply@Evasmom.com"

  def password_reset(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {
      :from    => ENV['mail_username'],
      :to      => @user.email,
      :subject => 'Password Reset',
      :html    => (render_to_string("../views/user_mailer/password_reset_#{@user.locale}.html")).to_str
    }
    mg_client.send_message ENV['domain'], message_params
  end

  def welcome(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {
      :from    => ENV['mail_username'],
      :to      => @user.email,
      :subject => 'Welcome to Eva妈妈',
      :html    => (render_to_string("../views/user_mailer/welcome_#{@user.locale}.html")).to_str
    }
    mg_client.send_message ENV['domain'], message_params
  end
end
