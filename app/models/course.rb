class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                    type: String
  field :description,              type: String
  field :teaching_experience,      type: Integer
  field :age_group,                type: Integer

  # relationships
  belongs_to :subject
  has_many   :bookings
  belongs_to :tutor_account

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates  :teaching_experience, presence: true,
                                   inclusion: { in: [0,1,2,3] }
  validates  :age_group,  inclusion: { in: [0,1,2,3,4] },
                          allow_nil: true
  validates  :title,     presence: true,
                         length: { maximum: 200 }
  validates  :description,     allow_nil: true,
                               length: { maximum: 1000 }
  def self.find_where_id(id)
    Course.where(id: id).last
  end

end