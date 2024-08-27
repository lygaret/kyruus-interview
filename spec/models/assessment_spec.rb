require 'rails_helper'

RSpec.describe Assessment, type: :model do
  it { is_expected.to validate_presence_of :check_in_id }
  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_inclusion_of(:key).in_array(%w[PHQ]) }

  describe "phq" do
    subject(:assessment) { create(:assessment_phq) }

    let (:response_json) do
      [
        { "qid" => 1, "resp" => 2 },
        { "qid" => 2, "resp" => 3}
      ]
    end

    let (:result_json) { { "score" => 3 } }

    describe "#response" do
      it "can store valid hashes" do
        assessment.update!(response: response_json)

        result = Assessment.find(assessment.id)
        expect(result.response).to match(response_json)
      end
    end

    describe "#result" do
      it "can store valid hashes" do
        assessment.update!(result: result_json)

        result = Assessment.find(assessment.id)
        expect(result.result).to match(result_json)
      end
    end
  end
end
