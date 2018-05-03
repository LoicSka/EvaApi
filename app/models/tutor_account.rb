class TutorAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :introduction,          type: String
  field :gender,                type: String
  field :dob,                   type: Time
  field :phone_number,          type: String
  field :weibo_url,             type: String
  field :wechat_id,             type: String
  field :occupation,            type: String
  field :days_available,        type: Array, default: []
  field :age_group,             type: Integer
  field :state,                 type: String, default: 'trial'
  field :renewed_at,            type: Time
  field :expiring_at,           type: Time
  field :membership,            type: String
  field :district,              type: String
  field :country_of_origin,     type: String

  # relationships
  belongs_to  :user
  has_many    :reviews, dependent: :destroy
  has_many    :courses, dependent: :destroy
  belongs_to  :region

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }
  # scope :by_subject, -> (subject_id) { where('courses.subject_id' => subject_id)}
  
  # validations
  validates :introduction,      presence: true,
                                length: { maximum: 1000 }
  validates :gender,            allow_nil: true,
                                inclusion: { in: %w{ male female }}
  validates :phone_number,      presence: true,
                                length: { maximum: 25 }
  validates :weibo_url,         length: { maximum: 200 },
                                allow_nil: true
  validates :wechat_id,         length: { maximum: 200 },
                                allow_nil: true
  validates :age_group,         inclusion: { in: [0,1,2,3,4] }
  validates :country_of_origin, length: { maximum: 200 },
                                allow_nil: true
  validates :occupation,        presence: true,
                                inclusion: { in: ['Full-time tutor', 'Part-time tutor'] }
  validate  :validate_dob
  validates :district,          allow_nil: true,
                                length: { maximum: 200 }
  validate  :validate_days_available
  validates :state,             presence: true,
                                inclusion: { in: %w{ trial inactive active deactivated }}

  def validate_days_available
    days_available.each_with_index do |available_day, index|
      errors.add(:days_available, "day at index #{index} in days available is invalid") if available_day < Time.now
    end
  end

  def validate_dob
    errors.add(:dob, "dob cannot be in the future... duh") if dob > Time.now unless dob.nil?
  end

  # returns highest teaching_experience value from tutor account courses
  def teaching_experience
    course = courses.max_by(&:teaching_experience)
    course.teaching_experience unless course.nil?
  end

  def bookings
    courses.flat_map { |course| course.bookings.accepted }
  end

  def available?(days)
    bookings.select { |booking| (booking.time & days).count > 0 }.empty?
  end

  def self.find_where_id(id)
    TutorAccount.where(id: id).last
  end

  # Filter by subject, returns array of Tutor Accounts objects
  def self.by_subject(subject_id)
    tutor_accounts = []
    Course.where(:subject_id => subject_id).each { |course| tutor_accounts.push(course.tutor_account) unless tutor_accounts.include? course.tutor_account}
    tutor_accounts
  end

  # Filter by age group, returns array of Tutor Accounts objects
  def self.by_age_group(age_group)
    tutor_accounts = []
    Course.where(:age_group.in => [age_group, 0]).each {|course| tutor_accounts.push(course.tutor_account) unless tutor_accounts.include? course.tutor_account}
    tutor_accounts
  end

  # Filter by price, returns array of Tutor Accounts objects
  def self.by_price_range(price_range)
    tutor_accounts = []
    Course.where(:hourly_rate.gte => price_range.first, :hourly_rate.lte => price_range.last).each { |course| tutor_accounts.push(course.tutor_account) unless tutor_accounts.include? course.tutor_account}
    tutor_accounts
  end

  def self.filter_with(age_group: nil, subject: nil, price_range: nil, available_days: [], region: nil)
    accounts_by_age_group = age_group.nil? ? [] : TutorAccount.by_age_group(age_group)
    accounts_by_subject = subject.nil? ? [] : TutorAccount.by_subject(subject)
    accounts_by_price_range = price_range.nil? ? [] : TutorAccount.by_price_range(price_range)
    accounts_by_region = region.nil? ? [] : TutorAccount.where(region_id: region)
    accounts = []
    [accounts_by_age_group, accounts_by_subject, accounts_by_price_range, accounts_by_region].each do |array|
      accounts &= array unless array.empty?
      accounts = array if accounts.empty?
    end
    available_days.empty? ? accounts : accounts.select { |account| account.available? available_days }
  end
  
end
