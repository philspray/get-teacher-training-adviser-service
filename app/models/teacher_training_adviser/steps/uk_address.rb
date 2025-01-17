module TeacherTrainingAdviser::Steps
  class UkAddress < GITWizard::Step
    attribute :address_line1, :string
    attribute :address_line2, :string
    attribute :address_city, :string
    attribute :address_postcode, :string

    validates :address_line1, presence: true, length: { maximum: 1024 }
    validates :address_line2, length: { maximum: 1024 }
    validates :address_city, presence: true, length: { maximum: 128 }
    validates :address_postcode, format: { with: /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, multiline: true }

    before_validation :sanitize_input

    def self.contains_personal_details?
      true
    end

    def skipped?
      other_step(:uk_or_overseas).uk_or_overseas != UkOrOverseas::OPTIONS[:uk]
    end

    def reviewable_answers
      address = [
        address_line1,
        address_line2,
        address_city,
        address_postcode,
      ].compact

      {
        "address" => address.reject(&:empty?).join("\n"),
      }
    end

  private

    def sanitize_input
      self.address_line1 = address_line1.to_s.strip.presence if address_line1
      self.address_line2 = address_line2.to_s.strip.presence if address_line2
      self.address_city = address_city.to_s.strip.presence if address_city
      self.address_postcode = address_postcode.to_s.strip.presence if address_postcode
    end
  end
end
