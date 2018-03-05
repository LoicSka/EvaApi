class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :teaching_experience,      type: Integer
  field :age_group,                type: Integer

  # relationships
  belongs_to :subject
  has_many   :bookings
  belongs_to :tutor_account

  # validations
  validates  :teaching_experience, presence: true,
                                   inclusion: { in: [0,1,2,3] }
  validates  :age_group, inclusion: { in: [0,1,2,3,4] },
                          allow_nil: true

  def self.find_where_id(id)
    Course.where(id: id).last
  end

end