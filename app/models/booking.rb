class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :time,              type: Array
  field :estimated_cost,    type: Float
  field :state,             type: String, default: 'pending'

  # relationships
  belongs_to  :user
  belongs_to  :course

  # scopes
  scope :sorted, -> { order_by(created_at: 'desc') }
  scope :accepted, -> { where(state: 'accepted')}

  # validations
  validates :time, presence: true,
                   enum: { presence: true }
  validates :state, presence: true,
                       inclusion: {in: %w{ pending accepted declined canceled }}

  def self.find_where_id(id)
    Booking.where(id: id).last
  end

end
