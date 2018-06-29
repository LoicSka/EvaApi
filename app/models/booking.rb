class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :time,              type: Time
  field :duration,          type: Integer
  field :days_of_week,      type: Array
  field :estimated_cost,    type: String
  field :state,             type: String, default: 'pending'
  field :previous_state,    type: String
  field :address,           type: String
  field :phone_number,      type: String

  # relationships
  belongs_to  :student
  belongs_to  :tutor_account

  # scopes
  scope :sorted, -> { order_by(created_at: 'desc') }
  scope :accepted, -> { where(state: 'accepted') }
  scope :confirmed, -> { where(state: 'confirmed') }
  scope :for_tutor, -> (tutor_account_id) { where(tutor_account_id: tutor_account_id) }
  scope :for_student, -> (student_id) { where(student_id: student_id) }

  # callbacks
  before_save  :set_estimated_cost, :handle_state_change  

  # validations
  validates :duration,    presence: true
  validates :address,     presence: true,
                          length: { maximum: 200 }
  validates :state,       presence: true,
                          inclusion: {in: %w{ pending accepted confirmed declined canceled }}

  def self.find_where_id(id)
    Booking.where(id: id).last
  end

  def set_estimated_cost
    self.estimated_cost = "#{tutor_account.hourly_rate * duration} #{tutor_account.region.currency_symbol}"
  end

  def self.for_user(user_id)
    bookings = []
    Student.where(user_id: user_id).each { |student| bookings.push student.bookings  }
    bookings.flatten
  end

  def self.seed
    Booking.delete_all
    TutorAccount.each do |tutor|
      booking = tutor.bookings.new
      booking.student = Student.sorted.last
      booking.time = 2.days.from_now
      booking.estimated_cost = '300¥'
      booking.duration = 2
      booking.days_of_week = [1,2]
      booking.state = 'confirmed'
      booking.address = '我知道了，我明天叫师傅去看看'
      booking.save
    end
  end

  def send_booking_request_email
    BookingMailer.request_new(self).deliver
  end

  def send_confirmation_email
    BookingMailer.confirmed(self, student.user).deliver
  end

  def send_cancel_notice_email
    BookingMailer.canceled(self, tutor_account.user, student.user).deliver
  end

  def send_decline_notice_email
    BookingMailer.declined(self).deliver
  end

  def handle_state_change
    if previous_state != state
      case state
      when 'pending'
        send_booking_request_email
      when 'confirmed'
        send_confirmation_email
      when 'canceled'
        send_cancel_notice_email
      when 'declined'
        send_decline_notice_email
      end
    end
    self.previous_state = state
  end

  def booked_days(locale: 'en')
    days ={
      'cn' => 
        {
          0 => "Sunday",
          1 => "Monday",
          2 => "Tuesday",
          3 => "Wednesday",
          4 => "Thursday",
          5 => "Friday",
          6 => "Saturday"
        }, 
      'en' => 
        {
          0 => "Sunday",
          1 => "Monday", 
          2 => "Tuesday",
          3 => "Wednesday",
          4 => "Thursday",
          5 => "Friday",
          6 => "Saturday"
        }
      } 
    if days_of_week.present?
      return days_of_week.map { |day| days[locale][day]}.join(', ')
    else
      self.time.strftime("%m/%d/%Y")
    end
  end

end
