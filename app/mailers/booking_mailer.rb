class BookingMailer < ApplicationMailer

    default from: "no-reply@Evasmom.com"

    def request_new(booking)
        @booking = booking
        @user = booking.tutor_account.user
        subject_text = @user.locale === 'cn' ? "You've got a new booking - CN" : "You've got a new booking!"
        mg_client = Mailgun::Client.new ENV['MAIL_GUN_API_KEY']
        message_params = {
            :from    => ENV['MAIL_USERNAME'],
            :to      => @user.email,
            :subject => subject_text,
            :html    => (render_to_string("../views/booking_mailer/new_#{@user.locale}.html")).to_str
        }
        mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params
    end

    def confirmed(booking, user)
        @booking = booking
        @user = user
        subject_text = @user.locale === 'cn' ? "Booking confirmed! - CN" : "Booking confirmed!"
        mg_client = Mailgun::Client.new ENV['MAIL_GUN_API_KEY']
        message_params = {
            :from    => ENV['MAIL_USERNAME'],
            :to      => @user.email,
            :subject => subject_text,
            :html    => (render_to_string("../views/booking_mailer/confirmed_#{@user.locale}.html")).to_str
        }
        mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params
    end

    def canceled(booking, user, canceler)
        @booking = booking
        @user = user
        @canceler = canceler
        subject_text = @user.locale === 'cn' ? "Booking canceled! - CN" : "Booking canceled!"
        mg_client = Mailgun::Client.new ENV['MAIL_GUN_API_KEY']
        message_params = {
            :from    => ENV['MAIL_USERNAME'],
            :to      => @user.email,
            :subject => subject_text,
            :html    => (render_to_string("../views/booking_mailer/canceled_#{@user.locale}.html")).to_str
        }
        mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params
    end

    def declined(booking)
        @booking = booking
        @user = booking.student.user
        subject_text = @user.locale === 'cn' ? "Booking declined! - CN" : "Booking declined!"
        mail to: @user.email, subject: subject_text, template_name: "declined_#{@user.locale}"
        mg_client = Mailgun::Client.new ENV['MAIL_GUN_API_KEY']
        message_params = {
            :from    => ENV['MAIL_USERNAME'],
            :to      => @user.email,
            :subject => subject_text,
            :html    => (render_to_string("../views/booking_mailer/declined_#{@user.locale}.html")).to_str
        }
        mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params
    end

end
