class Student
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :full_name,       type: String
  field :gender,          type: String
  field :age_group,       type: Integer
  field :days_available,  type: Array, default: []
  field :user_id,         type: String

  # relationships
  has_many   :criteria
  belongs_to :region
  belongs_to :subject
  has_and_belongs_to_many :tutor_accounts
  has_many :bookings, dependent: :destroy
  has_many :matches, dependent: :destroy

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  accepts_nested_attributes_for :criteria
  # callbacks
  before_validation :set_subject
  after_create :generate_match

  # validations
  validates :full_name, presence: true, length: { maximum: 200 }

  def self.find_where_id(id)
    Student.where(id: id).last
  end

  def set_subject
    self.subject = Subject.last
  end

  def has_matched_width?(tutor_account)
    !matches.where(tutor_account_id: tutor_account.id).empty?
  end

  def booking_count
    bookings.count
  end

  def user
    User.find_where_id(user_id) unless user_id.nil?
  end

  def generate_match
    tutor_accounts = TutorAccount.active.for_region(region.id).sort { |a,b| a.match_score(self) <=> b.match_score(self) }
    tutor_accounts.select! { |tutor_account| !(has_matched_width? tutor_account) }
    self.matches.create(tutor_account: tutor_accounts.last, score: tutor_accounts.last.match_score(self) ) if (!tutor_accounts.empty? && tutor_accounts.last.match_score(self) >= 0)
  end

end
