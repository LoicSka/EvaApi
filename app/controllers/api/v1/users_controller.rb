class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_user, only: [:show, :update, :destroy, :send_welcome_email, :verify_email]
  before_action :authenticate_user, except: [:index, :update, :create, :login, :verify_email ]
  before_action :format_params, only: [:update, :create]

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
    render 'api/v1/users/update.json'
  end

  # DELETE /users/1
  def destroy
    @user.destroy unless @user.nil?
  end

  def send_welcome_email
    render 'api/v1/users/show.json'
  end

  def verify_email
    unless @user.nil?
      @user.errors.add(:email, 'email verification failed') unless @user.verify_email params[:token]
      render 'api/v1/users/login.json'
    else
      render 'api/unauthorized'
    end
  end

  def login
    if params[:email].present? && params[:password].present?
      @user = User.where(email: params[:email]).last
      if @user.nil?
      elsif @user.authenticate(params[:password]) == false
        @user.errors.add(:password, "does not match email")
      elsif @user.authenticate(params[:password])
      end
    else
      @user = User.new
      @user.errors.add(:email, "not provided")
    end
  end

  private
  def set_user
    @user = User.find_where_id(params[:id])
  end

  def format_params
    keys = %w(region_id introduction gender dob district phone_number weibo_url wechat_id occupation days_available subject_ids state renewed_at expiring_at membership country_of_origin certifications teaching_experience levels)
    params[:tutor_account_attributes] = {}
    params.keys.each { |key| params[:tutor_account_attributes][key] = params[key] if keys.include? key }
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :avatar, tutor_account_attributes: [:introduction, :district, :gender, :dob, :phone_number, :weibo_url, :wechat_id, :occupation, :teaching_experience, :state, :renewed_at, :expiring_at, :membership, :country_of_origin, :region_id, levels: [], subject_ids: [], certifications: [], days_available: []])
  end

end
