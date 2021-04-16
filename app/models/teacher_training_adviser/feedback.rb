module TeacherTrainingAdviser
  class Feedback < ApplicationRecord
    before_validation :sanitize_input

    enum rating: {
      very_satisfied: 0,
      satisfied: 1,
      neither_satisfied_or_dissatisfied: 2,
      dissatisfied: 3,
      very_dissatisfied: 4,
    }

    validates :rating, presence: true, inclusion: { in: Feedback.ratings.keys }
    validates :successful_visit, inclusion: [true, false]
    validates :unsuccessful_visit_explanation, presence: true, if: -> { successful_visit == false }

  private

    def sanitize_input
      self.unsuccessful_visit_explanation = unsuccessful_visit_explanation&.strip.presence
      self.improvements = improvements&.strip.presence
    end
  end
end
