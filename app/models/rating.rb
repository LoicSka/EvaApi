class Rating
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value,        type: Integer
  field :review_id,    type: String

  # relationships
  belongs_to :user
  belongs_to :tutor_account
  has_one    :review, dependent: :destroy

  accepts_nested_attributes_for :review

  scope :for_tutor, -> (tutor_account_id) {where(:tutor_account_id => tutor_account_id)}
  scope :reviewed, -> { for_js("this.review_id !== null") }
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :value, presence: true
  validate :validate_eligibility

  def validate_eligibility
    errors.add(:user, 'eligibility') unless is_eligible? user
  end

  def self.find_where_id(id)
    Rating.where(id: id).last
  end

  def review_id
    review.id
  end

  def self.seed
    Rating.delete_all
    TutorAccount.all.each do |tutor|
      User.all.each do |user|
        Rating.create(value: (1..5).to_a.sample, user: user, tutor_account: tutor, review_attributes: {content: 'Well well well well, nice try...'})
      end
    end
  end

  def is_eligible?(user)
    user.id != tutor_account.user.id
  end

end
