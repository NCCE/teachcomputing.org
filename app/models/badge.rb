class Badge < ApplicationRecord
  belongs_to :programme
  validates :credly_badge_template_id, presence: true, uniqueness: true
  validates :academic_year, presence: true

  scope :active, -> { where(active: true) }

  class << self
    def seed_new_badges
      new_badges.select { |_, data| value[:type] == "Certificate" }.each do |template_id, data|
        programme = Programme.find_by(slug: data[:programme])
        next unless programme

        Badge.create(programme: programme, active: false, credly_badge_template_id: template_id, academic_year: "2024-25")
      end
    end

    private

    def new_badges
      {
        "b61ccbda-087a-4f74-abb1-23d5103242ba" => {programme: "primary-certificate", type: "ProfessionalDevelopment"},
        "ddb621a8-7498-4930-b3a6-71579fab351d" => {programme: "secondary-certificate", type: "ProfessionalDevelopment"},
        "4f693a15-b0d5-4bb8-bc29-1380126b52bc" => {programme: "subject-knowledge", type: "ProfessionalDevelopment"},
        "f0455ed3-aebe-4b87-9ace-f04a15a768e7" => {programme: "subject-knowledge", type: "Certificate"},
        "1495723f-838d-4b03-ac26-b95e1aa7e0de" => {programme: "primary-certificate", type: "Certificate"},
        "eaa97a17-d00c-49eb-8dac-2b7840b1618a" => {programme: "secondary-certificate", type: "Certificate"},
        "1ddd6b6a-945a-4efc-8ab8-0f284d739ab4" => {programme: "i-belong", type: "Certificate"},
        "1b53f7b0-2850-4142-a8eb-e9ed9e2581e7" => {programme: "a-level-certificate", type: "Certificate"}
      }
    end
  end
end
