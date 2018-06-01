class Student
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :full_name,       type: String
  field :gender,          type: String
  field :days_available,  type: Array, default: []

  # relationships
  # belongs_to :user
  has_many   :criteria
  belongs_to :region
  belongs_to :subject
  has_and_belongs_to_many :tutor_accounts
  has_many :bookings

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  accepts_nested_attributes_for :criteria

  before_validation :set_subject

  # validations
  validates :full_name, presence: true, length: { maximum: 200 }

  def self.find_where_id(id)
    Student.where(id: id).last
  end

  def set_subject
    self.subject = Subject.last
  end

end
