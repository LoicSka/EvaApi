class Api::V1::BookingsController < Api::V1::BaseController

  before_action :set_page, only: [:index]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user # , except: [:create, :update]

  def index
    @bookings = params['page_number'].present? ? Booking.sorted.paginate(:page => @page_number, :per_page => @page_size) : Booking.sorted
  end

  def show
  end

  def create
    @booking = Booking.new(bookings_params)
    @booking.save
  end

  def update
    @booking.update(bookings_params)
  end

  def destroy
    @booking.destroy unless @booking.nil?
  end

  private

  def set_booking
    @booking = Booking.find_where_id(params[:id])
  end

  def bookings_params
    params.permit(:time, :estimated_cost, :user_id, :course_id)
  end

end