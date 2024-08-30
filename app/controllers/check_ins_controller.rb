class CheckInsController < ApplicationController
  def new
  end

  def create
    check_in = CheckInService.check_in!(patient_id: "1")
    redirect_to check_in_path(check_in)
  end

  def show
    @check_in = CheckIn.find(params[:id])
    @personalization_info = PersonalizationService.fetch!(patient_id: @check_in.patient_id)
  end
end
