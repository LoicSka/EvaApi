class Student
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :fullname, type: String
  field :gender,   type: String 

  # relationships
  # belongs_to :user
  has_many   :criteria

  accepts_nested_attributes_for :criteria

  # validations
  validates :full_name, presence: true, length: { maximum: 200 }

  def self.find_where_id(id)
    Student.where(id: id).last
  end

end
