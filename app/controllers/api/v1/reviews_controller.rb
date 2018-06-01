class Api::V1::ReviewsController < Api::V1::BaseController
  before_action :set_page, only: [:index, :for_tutor]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user # , except: [:create, :update]
  after_action :mark_as_seen, only: [:index, :for_tutor]

  def index
    @reviews = params['page_number'].present? ? Review.sorted.paginate(:page => @page_number, :per_page => @page_size) : Review.sorted
  end

  def for_tutor
    @reviews = params['page_number'].present? ? Review.sorted.for_tutor(params[:id]).paginate(:page => @page_number, :per_page => @page_size) : Review.sorted.for_tutor(params[:id])
    render 'api/v1/reviews/index.json'
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

  def mark_as_seen
    if current_user.tutor?
      current_user.tutor_account.mark_as_seen(reviews: true)
    end
  end

  def reviews_params
    params.permit(:content, :tutor_account_id, :user_id)
  end
end
