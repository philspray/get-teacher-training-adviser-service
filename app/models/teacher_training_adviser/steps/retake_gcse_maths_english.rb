module TeacherTrainingAdviser::Steps
  class RetakeGcseMathsEnglish < Wizard::Step
    attribute :planning_to_retake_gcse_maths_and_english_id, :integer

    validates :planning_to_retake_gcse_maths_and_english_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["planning_to_retake_gcse_maths_and_english_id"] =
          OPTIONS.key(planning_to_retake_gcse_maths_and_english_id).to_s.capitalize
      end
    end

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["has_gcse_maths_and_english_id"] != TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
    end
  end
end
