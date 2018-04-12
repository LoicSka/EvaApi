class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  # relationship
  belongs_to :tutor_account
  belongs_to :user

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :content, presence: true, length: { maximum: 1000 }

  def self.find_where_id(id)
    Review.where(id: id).last
  end
end
