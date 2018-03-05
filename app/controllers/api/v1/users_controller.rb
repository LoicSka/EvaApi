class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:create, :update, :login]

  def index
    @users = params['page_number'].present? ? User.sorted.paginate(:page => @page_number, :per_page => @page_size) : User.sorted
  end

  # GET /users/1
  def show
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def update
    @user.update(user_params)
  end

  # DELETE /users/1
  def destroy
    @user.destroy unless @user.nil?
  end

  def login
    if params[:email].present? && params[:password].present?
      @user = User.where(email: params[:email]).last
      if @user.nil?
        render 'api/v1/users/show'
      elsif @user.authenticate(params[:password]) == false
        @user.errors.add(:password, "does not match email")
        render 'api/v1/users/create'
      elsif @user.authenticate(params[:password])
        render 'api/v1/users/create'
      end
    else
      @user = User.new
      @user.errors.add(:email, "not provided")
      render 'api/v1/users/create'
    end
  end

  private
  def set_user
    @user = User.find_where_id(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:first_name, :last_name, :email, :password, tutor_account_attributes: [:introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :membership])
  end

end
