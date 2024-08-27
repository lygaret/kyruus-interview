module AssessmentSubmissionService
  extend self

  # creates a check in, and populates expected check in assessments
  def submit!(assessment_id:, response:)
    ActiveRecord::Base.transaction do
      assessment = Assessment.find(assessment_id)

      # set and save the response
      # then reload, and determine the result

      assessment.update!(response:)
      assessment.calculate_result!
      assessment
    end
  end

end
