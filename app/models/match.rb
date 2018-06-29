class Match
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, type: Integer

  belongs_to :tutor_account
  belongs_to :student

  # scopes
  scope :sorted, -> { order_by(:created_at => 'desc') }

end
