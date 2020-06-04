class UkOrOverseas < Base
  attribute :uk_or_overseas, :string
  
  validates :uk_or_overseas, inclusion: { in: %w(uk overseas), message: "You must select an option" }

  def next_step
    if uk_or_overseas == "uk"
      "uk_candidate"
    else
      "overseas_candidate"
    end
  end
end