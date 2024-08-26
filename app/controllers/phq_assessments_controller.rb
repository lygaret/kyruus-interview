class PhqAssessmentsController < ApplicationController
  def new
    @check_in = CheckIn.find(params[:check_in_id])
  end
end
