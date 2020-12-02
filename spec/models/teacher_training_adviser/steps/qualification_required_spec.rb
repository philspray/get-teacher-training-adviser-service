require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::QualificationRequired do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns false if RetakeGcseMathsEnglish was shown and they selected no" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish).to receive(:skipped?) { false }
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns false if RetakeGcseScience was shown and they selected no" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseScience).to receive(:skipped?) { false }
      wizardstore["planning_to_retake_gcse_science_id"] = TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if RetakeGcseMathsEnglish was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if RetakeGcseMathsEnglish was shown and they selected yes" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish).to receive(:skipped?) { false }
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true if RetakeGcseScience was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseScience).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if RetakeGcseScience was shown and they selected yes" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::RetakeGcseScience).to receive(:skipped?) { false }
      wizardstore["planning_to_retake_gcse_science_id"] = TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end
end
