class Api::V1::RatingsController < Api::V1::BaseController
  before_action :authenticate_user , only: [:create]
  before_action :set_page, only: [:index]

  def index
    @ratings = params['page_number'].present? ? Rating.reviewed.sorted.for_tutor(params[:tutor_account_id]).paginate(:page => @page_number, :per_page => @page_size) : Region.sorted
  end

  def create
    @rating = Rating.find_or_initialize_by(ratings_params.slice(:user_id, :tutor_account_id))
    @rating.review_attributes = params[:review_attributes]
    @rating.value = params.value
    @rating.save
  end

  private

  def ratings_params
    params.permit(:value, :user_id, :tutor_account_id, review_attributes: [:content])
  end
end
