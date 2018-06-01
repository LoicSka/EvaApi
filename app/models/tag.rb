class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,    type: String
  field :sub_title,type: String

  # relationships
  has_and_belongs_to_many :users
  has_and_belongs_to_many :courses

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  validates :title,  presence: true,
                     length: { maximum: 500 }
  validates :sub_title, presence: true,
                        length: { maximum: 800 }
end
