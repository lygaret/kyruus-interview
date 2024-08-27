class AssessmentsController < ApplicationController

  before_action :find_assessment

  def show
    render assessment_template
  end

  def update
    AssessmentSubmissionService.submit!(assessment_id: @assessment.id, params:)

    redirect_to check_in_path(@assessment.check_in)
  end

  private

  def assessment_template
    @assessment.key.downcase
  end

  def find_assessment
    @assessment = Assessment.find_by(id: params[:id], check_in_id: params[:check_in_id])
  end

end
