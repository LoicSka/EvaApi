class Api::V1::PasswordResetsController < Api::V1::BaseController
    def create
        @user = User.find_by_email(params[:email])
        @user.send_password_reset if @user
    end

    def reset
        @user = User.where(password_reset_token: params[:password_reset_token]).last
        if @user
            if @user.password_reset_token_sent_at < 24.hours.ago
                @user.update(password_reset_params) 
            else
                @user.errors[:password_reset_token] = 'Token expired.'
            end
        end
    end
    
    private

    def password_reset_params
        params.permit(:password)
    end
end
