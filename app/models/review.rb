class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :tutor_account_id, type: String

  # relationship
  belongs_to :rating

  # scopes
  scope :for_tutor, -> (tutor_account_id) { for_js("this.tutor_account_id = tutor_account_id", tutor_account_id: tutor_account_id)}
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :content, presence: true, length: { maximum: 1000 }

  def self.find_where_id(id)
    Review.where(id: id).last
  end

  def tutor_account_id
    rating.tutor_account_id
  end

end
