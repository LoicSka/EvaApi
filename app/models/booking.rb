class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :time,              type: Array
  field :estimated_cost,    type: Float

  # relationships
  belongs_to  :user
  belongs_to  :course

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

  # validations
  validates :time, presence: true,
                   enum: { presence: true }

  def self.find_where_id(id)
    Booking.where(id: id).last
  end

end
