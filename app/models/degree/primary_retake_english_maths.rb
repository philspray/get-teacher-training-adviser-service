module Degree
  class PrimaryRetakeEnglishMaths < PrimaryRetakeEnglishMaths
    def next_step
      if planning_to_retake_gcse_maths_and_english_id == OPTIONS[:yes]
        "degree/science_grade4"
      else
        "qualification_required"
      end
    end
  end
end
