class Api::V1::UsersController < Api::V1::BaseController

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

  private
  def set_user
    @user = User.find_where_id(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:first_name, :last_name, :email_address, :password, tutor_account_attributes: [:introduction, :gender, :dob, :phone_number, :weibo_url, :wechat_url, :occupation, :days_available, :state, :renewed_at, :expiring_at, :membership])
  end

end
