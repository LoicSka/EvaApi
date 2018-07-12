class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                    type: String
  field :description,              type: String
  field :teaching_experience,      type: Integer
  field :expertise,                type: Integer
  field :age_group,                type: Integer
  field :hourly_rate,              type: Integer

  # relationships
  belongs_to :subject
  has_many   :bookings
  belongs_to :tutor_account
  has_and_belongs_to_many :tags

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates  :teaching_experience, presence: true,
                                   inclusion: { in: [0,1,2,3,4,5] }
  validates  :age_group,  inclusion: { in: [0,1,2,3,4] },
                          allow_nil: true
  validates  :expertise,  inclusion: { in: [0,1,2,3,4] },
                          allow_nil: true
  validates  :title,     presence: true,
                         length: { maximum: 200 }
  validates  :description,     allow_nil: true,
                               length: { maximum: 1000 }
  def self.find_where_id(id)
    Course.where(id: id).last
  end

  def self.accepted_bookings
    bookings.accepted
  end
end