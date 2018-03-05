class TutorAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :introduction,          type: String
  field :gender,                type: String
  field :dob,                   type: Time
  field :phone_number,          type: String
  field :weibo_url,             type: String
  field :wechat_url,            type: String
  field :occupation,            type: String
  field :days_available,        type: Array, default: []
  field :state,                 type: String
  field :renewed_at,            type: Time
  field :expiring_at,           type: Time
  field :membership,            type: String

  # relationships
  belongs_to  :user
  has_many    :reviews, dependent: :destroy
  belongs_to  :region

  # validations
  validates :introduction,   presence: true,
                             length: { maximum: 1000 }
  validates :gender,         allow_nil: true,
                             inclusion: { in: %w{ male female }}
  validate  :validate_dob
  validates :phone_number,   presence: true,
                             length: { maximum: 25 }
  validates :weibo_url,      length: { maximum: 200 },
                             allow_nil: true
  validates :wechat_url,     length: { maximum: 200 },
                             allow_nil: true
  validates :occupation,     presence: true,
                             inclusion: { in: %w{ professional part-time }}
  validate  :validate_days_available
  validates :state,          presence: true,
                             inclusion: { in: %w{ trial inactive active deactivated }}

  def validate_dob
    errors.add(:dob, 'date of birth cannot be in the future.') if dob > Time.now
  end

  def validate_days_available
    days_available.each_with_index do |available_day, index|
      errors.add(:days_available, "day at index #{index} in days available is invalid") if available_day < Time.now
    end
  end

  def self.find_where_id(id)
    TutorAccount.where(id: id).last
  end

end
