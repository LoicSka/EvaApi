class Criterion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,    type: String
  field :values,   type: Array, default: []

  CRITERION_TYPES = %w{ AGE_GROUP TUTOR_GENDER CURRENT_LEVEL WEAK_POINTS DISTRICT  }

  # relationships
  belongs_to :student
  # callbacks
  before_validation :format_values

  # validations
  validates :type,       presence: true,
            inclusion: { in: CRITERION_TYPES}
  validates :values,     presence: true,
            length: { maximum: 20 }

  def format_values
    self.values = self.values.map { |value| value.to_s }
  end

  # return a score
  def score_for(tutor_account)
    case type
    when 'AGE_GROUP'
      return value_for(value: tutor_account.age_group)
    when 'TUTOR_GENDER'
      return value_for(value: tutor_account.gender, correct: 5)
    when 'CURRENT_LEVEL'
      return value_for(value: tutor_account.level, neutral: nil)
    when 'DISTRICT'
      return value_for(value: tutor_account.district)
    when 'WEAK_POINTS'
      tags = tutor_account.tags_for_subject(student.subject).map { |tag| tag.id } & values
      return tags.count * 2
    else
      return 0
    end
  end


  def value_for(value:, neutral: 0, correct: 2, incorrect: 0)
    return correct if values.include? value
    return incorrect if value == neutral
    0
  end

end
