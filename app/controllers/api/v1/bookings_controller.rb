class Api::V1::BookingsController < Api::V1::BaseController

  before_action :set_page, only: [:index]
  before_action :set_bookings, only: [:index]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user # , except: [:create, :update]
  after_action  :mark_as_seen, only: [:index]

  def index
    @bookings = params['page_number'].present? ? @filtered_bookings.paginate(:page => @page_number, :per_page => @page_size) : @filtered_bookings
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

  def mark_as_seen
    if current_user.tutor?
      current_user.tutor_account.mark_as_seen(bookings: true)
    end
  end

  def set_bookings
    if params['tutor_account_id'].present?
      @filtered_bookings = Booking.for_tutor(params['tutor_account_id']).sorted
    elsif params['student_id'].present?
      @filtered_bookings = Booking.for_student(params['student_id']).sorted
    elsif params['user_id'].present?
      @filtered_bookings = Booking.for_user(params['user_id'])
    else
      @filtered_bookings = Booking.sorted
    end
  end

  def bookings_params
    params.permit(:time, :duration, :phone_number, :days_of_week, :estimated_cost, :address, :tutor_account_id, :student_id, :state)
  end

end