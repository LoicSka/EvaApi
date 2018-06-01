class Region
  include Mongoid::Document
  include Mongoid::Timestamps

  field :country_name,      type: Array
  field :city_name,         type: Array
  field :location,          type: Array
  field :currency_symbol,   type: String

  # relationships
  has_many :tutor_accounts
  has_many :students

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :country_name,         presence: true,
                                   length: { maximum: 90 }
  validates :city_name,            presence: true,
                                   length: { maximum: 90 }
  validates :currency_symbol,      presence: true,
                                   length: { maximum: 5 }

  def self.find_where_id(id)
    Region.where(id: id).last
  end

  def self.seed
    Region.delete_all
    Region.create(city_name: ['Shanghai', '上海市'], country_name: ['China', '中国'], location: [31.2304,121.4737], currency_symbol: '¥' )
    Region.create(city_name: ['Nanjing', '南京市'], country_name: ['China', '中国'], location: [32.0603,118.7969], currency_symbol: '¥' )
  end
end
