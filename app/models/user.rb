class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  include BCrypt

  # describe user fields
  field :first_name,                    	type: String
  field :last_name,                     	type: String
  field :email,                           type: String
  field :password_hash,                   type: String
  field :password_reset_token,            type: String
  field :password_reset_token_sent_at,    type: Time
  field :verified,                        type: Boolean, default: false
  field :avatar,                          type: String
  field :verification_token,              type: String
  field :student_ids,                     type: Array, default: []
  field :locale,                          type: String, default: 'cn'

  # relationships
  has_one    :tutor_account, dependent: :destroy
  has_many   :ratings,       dependent: :destroy
  # has_many   :students

  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tutor_account
  mount_uploader	  :avatar, AvatarUploader

  # callbacks

  # send welcome email
  before_create :generate_verification_token
  after_create  :send_welcome_email
  before_save   :lowercase_email

  # validations
  # email regular expression to check email format
  EMAIL_REGEX = /\A(\S+)@(.+)\.(\S+)\z/
  validates :first_name,     presence: true,
                             length: { maximum: 50 }
  validates :last_name,      presence: true,
                             length: { maximum: 50 }
  validates :email,  length: { within: 0..100 },
                     uniqueness: true,
                     format: EMAIL_REGEX
  validates :password,       presence: true, length: { within: 4..100 }

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # find user by email
  def self.find_by_email(email)
    where(email: email).first
  end

  def students
    student_ids.map { |id| Student.find_where_id(id) }.compact
  end
  # set up bcrypt gem password encryption
  def password
    @password = Password.new(password_hash) unless password_hash.blank?
  end

  # set password
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.from_token_payload(payload)
    User.where(id: payload['_id']).last
  end

  def to_token_payload
    { id: id, email: email, full_name: full_name, avatar_url: avatar_url, is_tutor: tutor_account.present? }
  end

  # returns user's full name
  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def self.find_where_id(id)
    User.where(id: id).last
  end

  # Generate password reset token
  def generate_password_reset_token
    self.password_reset_token = SecureRandom.urlsafe_base64
  end

  def generate_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

  # lowercase the user email
  def lowercase_email
    email.downcase! if email.present?
  end

  def avatar_url
    (Rails.env.production? ? "http://d27gl9vrxwy0se.cloudfront.net#{avatar.url}" : "http://localhost:3000#{avatar.url}") if avatar.present?
  end

  def authenticate(unencrypted_password)
    if Password.new(password_hash) == unencrypted_password
      return self
    else
      return false
    end
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def verify_email(token)
    if token == verification_token
      self.verified = true
      save!
    end
    verified
  end

  def verified?
    verified
  end

  def tutor?
    !tutor_account.nil?
  end

  def format_created_at
    created_at.to_s(:short_ordinal)
  end

  # Sending password reset email
  def send_password_reset
    generate_token
    self.password_reset_token_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  # Generate password reset token
  def generate_token
      self.password_reset_token = SecureRandom.urlsafe_base64
  end

end




