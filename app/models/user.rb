class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  include BCrypt

  # describe user fields
  field :first_name,                    	type: String
  field :last_name,                     	type: String
  field :email_address,                   type: String
  field :password_hash,                   type: String
  field :password_reset_token,            type: String
  field :password_reset_token_sent_at,    type: Time

  # relationships
  has_one    :tutor_account
  has_many   :reviews, dependent: :destroy
  has_many   :bookings

  accepts_nested_attributes_for :tutor_account

  # callbacks
  before_save   :lowercase_email

  # validations
  # email regular expression to check email format
  EMAIL_REGEX = /\A(\S+)@(.+)\.(\S+)\z/
  validates :first_name,     presence: true,
                             length: { maximum: 50 }
  validates :last_name,      presence: true,
                             length: { maximum: 50 }
  validates :email_address,  length: { within: 0..100 },
                             format: EMAIL_REGEX
  validates :password,       presence: true, length: { within: 4..100 }

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # find user by email
  def self.find_by_email(email_address)
    where(email_address: email_address).first
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

  # returns user's full name
  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def self.find_where_id(id)
    User.where(id: id).last
  end

  # Generate password reset token
  def generate_token
    self.password_reset_token = SecureRandom.urlsafe_base64
  end

  # lowercase the user email
  def lowercase_email
    email_address.downcase! if email_address.present?
  end

  def authenticate(unencrypted_password)
    if Password.new(password_hash) == unencrypted_password
      return self
    else
      return false
    end
  end

end



