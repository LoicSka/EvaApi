class Api::V1::ReviewsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user # , except: [:create, :update]

  def index
    @reviews = params['page_number'].present? ? Review.sorted.paginate(:page => @page_number, :per_page => @page_size) : Review.sorted
  end

  def show
  end

  def create
    @review = Review.new(reviews_params)
    @review.save
  end

  def update
    @review.update(reviews_params)
  end

  def destroy
    @review.destroy unless @review.nil?
  end

  private

  def set_review
    @review = Review.find_where_id(params[:id])
  end

  def reviews_params
    params.permit(:content, :tutor_account_id, :user_id)
  end
end
