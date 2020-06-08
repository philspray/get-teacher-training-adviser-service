class SecondaryMathsEnglishGrade4 < Base
  attribute :has_required_subjects, :string

  validates :has_required_subjects, inclusion: { in: %w(yes no), message: "You must select an option"}

  def next_step
    if has_required_subjects == "yes"
      "subject_interested_teaching"
    else
      "retake_english_maths"
    end
  end


end 