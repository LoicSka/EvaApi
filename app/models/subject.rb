class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: Array

  # relationships
  has_many :courses
  has_many :students
  has_and_belongs_to_many :tutor_accounts

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :title, presence: true,
                    length: { maximum: 10 },
                    uniqueness: true

  def self.find_where_id(id)
    Subject.where(id: id).last
  end

  def self.seed
    Subject.delete_all
    Subject.create(title: ['English', '英语'])
  end

end
