class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  # relationships
  has_many :courses

  # validations
  validates :title, presence: true, length: { maximum: 200 }

  def self.find_where_id(id)
    Subject.where(id: id).last
  end
end
