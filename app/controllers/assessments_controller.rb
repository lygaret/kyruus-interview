class AssessmentsController < ApplicationController

  before_action :find_assessment

  def show
  end

  def update
    # parse the incoming to an integer
    # in a non-form world, I'd probably do this with JSON
    resp_params = params.permit(response: [:qid, :score]).to_h
    resp_params = resp_params["response"]
    resp_params.each { |r| r.transform_values! { |v| v.to_i } }

    AssessmentSubmissionService.submit!(assessment_id: @assessment.id, response: resp_params)

    # done
    redirect_to check_in_path(@assessment.check_in)
  end

  private

  def find_assessment
    @assessment = Assessment.find_by(id: params[:id], check_in_id: params[:check_in_id])
  end

end
