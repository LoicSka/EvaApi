class Region
  include Mongoid::Document
  include Mongoid::Timestamps

  field :country_name,      type: String
  field :city_name,         type: String
  field :district,          type: String   
  field :location,          type: Array
  field :currency_symbol,   type: String

  # relationships
  has_many :tutor_accounts

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :country_name,         presence: true,
                                   length: { maximum: 90 }
  validates :city_name,            presence: true,
                                   length: { maximum: 90 }
  validates :district,             allow_nil: true,
                                   length: { maximum: 90 }
  validates :currency_symbol,      presence: true,
                                   length: { maximum: 90 }

  def self.find_where_id(id)
    Region.where(id: id).last
  end
end
