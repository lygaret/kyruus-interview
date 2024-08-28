require 'rails_helper'

RSpec.describe Assessment, type: :model do
  it { is_expected.to validate_presence_of :check_in_id }
  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_inclusion_of(:key).in_array(%w[PHQ]) }

  describe "phq" do
    subject(:assessment) { create(:assessment_phq) }

    let (:response_json) do
      [
        { "qid" => 1, "score" => 2 },
        { "qid" => 2, "score" => 3 }
      ]
    end

    let (:result_json) do
      {
        "total_score" => 3,
        "needs_screen" => false
      }
    end

    describe "#response" do
      it "can store valid hashes" do
        assessment.update!(response: response_json)

        result = Assessment.find(assessment.id)
        expect(result.response).to match(response_json)
      end

      it "can not store invalid hashes" do
        assessment.response = { "wrong" => :format }

        expect(assessment).not_to be_valid
        expect(assessment.errors).to have_key(:response)
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
