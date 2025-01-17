module TeacherTrainingAdviser::Steps
  class WhatDegreeClass < GITWizard::Step
    extend ApiOptions

    OMIT_GRADE_IDS = [
      222_750_004, # Third class or below
      222_750_005, # Unknown
    ].freeze

    attribute :uk_degree_grade_id, :integer

    def self.options
      generate_api_options(GetIntoTeachingApiClient::PickListItemsApi, :get_qualification_uk_degree_grades, OMIT_GRADE_IDS)
    end

    validates :uk_degree_grade_id, inclusion: { in: options.values.map(&:to_i) }

    def skipped?
      other_step(:what_subject_degree).skipped?
    end

    def studying?
      other_step(:have_a_degree).degree_options == HaveADegree::DEGREE_OPTIONS[:studying]
    end

    def reviewable_answers
      super.tap do |answers|
        answers["uk_degree_grade_id"] = self.class.options.key(uk_degree_grade_id)
      end
    end
  end
end
