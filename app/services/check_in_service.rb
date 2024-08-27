module CheckInService

  extend self

  # creates a check in, and populates expected check in assessments
  def check_in!(patient_id:)
    ActiveRecord::Base.transaction do
      c = CheckIn.create!(patient_id:)
      c.assessments.create!(key: "PHQ")

      c
    end
  end

end
