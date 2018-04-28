class Criterion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,    type: String
  field :values,   type: Array

  CRITERION_TYPES = %w{ AGE TUTOR_GENDER STUDENT_GENDER CURRENT_LEVEL WEAK_POINTS DAYS_AVAILABLE REGION DISTRICT }

  # relationships
  belongs_to :student

  validates :type,       presence: true, 
            inclusion: { in: CRITERION_TYPES}
  validates :values,     presence: true,
                         length: { minimum: 1, maximum: 20 }  

end
