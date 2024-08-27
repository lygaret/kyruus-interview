module AssessmentSubmissionService
  extend self

  # creates a check in, and populates expected check in assessments
  def submit!(assessment_id:, params:)
    ActiveRecord::Base.transaction do
      assessment = Assessment.find(assessment_id)

      # the assessment knows how to go from params to response
      response = assessment.process_params!(params)
      assessment.update!(response:)

      # and how to calculate
      assessment.calculate_result!

      # return when we're done
      assessment
    end
  end

end
