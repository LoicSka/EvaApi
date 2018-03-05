class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  # relationships
  has_many :courses

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :title, presence: true,
                    length: { maximum: 200 },
                    uniqueness: true

  def self.find_where_id(id)
    Subject.where(id: id).last
  end

end
