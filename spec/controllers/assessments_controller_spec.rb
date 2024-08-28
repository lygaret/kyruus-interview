require 'rails_helper'

RSpec.describe AssessmentsController, type: :controller do
  describe "routing" do
    it { should route(:get, "/check_ins/3/assessments/1").to(action: :show, id: 1, check_in_id: 3) }
    it { should route(:put, "/check_ins/3/assessments/1").to(action: :update, id: 1, check_in_id: 3) }
  end

  let!(:assessment) { create(:assessment_phq) }

  describe "GET #show" do
    it "renders the assessment specific view" do
      get :show, params: { check_in_id: assessment.check_in_id, id: assessment.id }

      expect(response).to render_template(:phq)
      expect(response).to render_with_layout(:application)
    end
  end
end
