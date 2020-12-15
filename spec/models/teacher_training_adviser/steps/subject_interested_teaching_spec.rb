require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::SubjectInterestedTeaching do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API lookup items as options",
                  :get_teaching_subjects, described_class::OMIT_SUBJECT_IDS

  context "attributes" do
    it { is_expected.to respond_to :preferred_teaching_subject_id }
  end

  describe "#preferred_teaching_subject_id" do
    it "allows a valid preferred_teaching_subject_id" do
      subject_item = GetIntoTeachingApiClient::LookupItem.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [subject_item] }
      expect(subject).to allow_value(subject_item.id).for :preferred_teaching_subject_id
    end

    it { is_expected.to_not allow_values("", nil, "invalid-id").for :preferred_teaching_subject_id }
  end

  describe "#skipped?" do
    it "returns false if StageInterestedTeaching step was shown and preferred_education_phase_id is secondary" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::StageInterestedTeaching).to receive(:skipped?) { false }
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      expect(subject).to_not be_skipped
    end

    it "returns true if StageInterestedTeaching was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::StageInterestedTeaching).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if education phase is primary" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    let(:lookup_item) { GetIntoTeachingApiClient::LookupItem.new(id: "123", value: "Value") }
    before do
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [lookup_item] }
      instance.preferred_teaching_subject_id = lookup_item.id
    end

    it { is_expected.to eq({ "preferred_teaching_subject_id" => "Value" }) }
  end
end
