class TutorAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :introduction,          type: String
  field :gender,                type: String
  field :dob,                   type: Time
  field :phone_number,          type: String
  field :weibo_url,             type: String
  field :wechat_id,             type: String
  field :levels,                type: Array,  default: []
  field :occupation,            type: String
  field :days_available,        type: Array,  default: []
  field :state,                 type: String, default: 'trial'
  field :renewed_at,            type: Time
  field :expiring_at,           type: Time,   default: Time.now + 1.month
  field :membership,            type: String
  field :district,              type: String
  field :country_of_origin,     type: String
  field :teaching_experience,   type: Integer
  field :certifications,        type: Array,  default: []
  field :last_seen,             type: Hash,   default: {}
  field :age_groups,            type: Array,  default: []
  field :hourly_rate,           type: Float,  default: 1

  # relationships
  belongs_to              :user
  has_many                :ratings, dependent: :destroy
  has_many                :courses, dependent: :destroy
  belongs_to              :region
  has_many                :bookings, dependent: :destroy
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :students

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }
  scope :active, -> { where(:expiring_at.gte => Time.now ) }
  scope :for_region, -> (region_id) { where(:region_id => region_id ) }
  # scope :by_subject, -> (subject_id) { where('courses.subject_id' => subject_id)}

  VALID_LEVELS = [0,1,2,3,4,5,6,7]
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
  # validate  :validate_levels
  validates :country_of_origin, length: { maximum: 200 },
                                allow_nil: true
  validates :occupation,        allow_nil: true,
                                inclusion: { in: ['Full-time tutor', 'Part-time tutor'] }
  validates :district,          allow_nil: true,
                                length: { maximum: 200 }
  validates :state,             presence: true,
                                inclusion: { in: %w{ trial inactive active deactivated } }

  def validate_levels
    errors.add(:levels, 'invalid value for levels') unless VALID_LEVELS & levels == levels.sort
    errors.add(:levels, 'levels is required') if levels.empty?
  end

  # returns highest teaching_experience value from tutor account courses
  # def teaching_experience
  #   course = courses.max_by(&:teaching_experience)
  #   course.teaching_experience unless course.nil?
  # end

  # def bookings
  #   courses.flat_map { |course| course.bookings.accepted }
  # end

  def available?(days)
    # bookings.select { |booking| (booking.time & days).count > 0 }.empty?
  end

  def teaches?(subject)
    subjects.include? subject
  end

  def tags_for_subject(subject)
    values = []
    courses.each {|course| (values.push course.tags) if course.subject == subject }
    values.flatten
  end

  def match_score(student)
    score = 0
    return score unless (student.region == region) && (teaches? student.subject)
    return score if (student.days_available & days_available).empty?
    student.criteria.each { |criterion| score += criterion.score_for(self) }
    score
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

  def self.sorted_by_match_score_for(student)
    TutorAccount.active.sort { |x,y| x.match_score(student) <=> y.match_score(student) }
  end

  def subject_titles
    subjects.map { |subject| subject.title }.flatten
  end

  # average rating value
  def rating
    ratings.count > 0 ? ratings.map { |r| r.value }.sum/ratings.count : 2
  end

  def mark_as_seen(reviews: false, bookings: false)
    self.last_seen = self.last_seen.merge({reviews: reviews ? review_count : last_seen[:reviews], bookings: bookings ? booking_count : last_seen[:bookings] })
    save
  end

  # total number of student taught through bookings
  def student_count
    student_ids = bookings.confirmed.map { |booking| booking.student_id  }
    student_ids.uniq.count
  end

  def review_count
    Review.for_tutor(self.id).count
  end

  def booking_count
    bookings.count
  end

  def booked_days
    bookings.confirmed.map { |booking| booking.time }
  end
  
end
