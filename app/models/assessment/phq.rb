class Assessment
  class PHQ < Assessment

    QUESTIONS = [
      { qid: 1, prompt: "Little interest or pleasure in doing things?" },
      { qid: 2, prompt: "Feeling down, depressed or hopeless?" },
    ]

    RESPONSES = [
      { score: 0, label: "Not at all" },
      { score: 1, label: "Several days" },
      { score: 2, label: "More than half the days" },
      { score: 3, label: "Nearly every day" },
    ]

    validates :response, json_schema: {
      type: "array",
      items: {
        type: "object",
        required: ["qid", "score"],
        properties: {
          "qid"   => { type: "integer" },
          "score" => { type: "integer", minimum: 0, maximum: 3}
        },
      }
    }

    # in the future, these will be metaprogrammed out of the base class
    # but the idea is basically the same

    def questions = QUESTIONS
    def responses = RESPONSES

    def process_params!(params)
      resp_params = params.permit(response: [:qid, :score])
      resp_params = resp_params["response"]

      resp_params.map do |r|
        r.transform_values { |v| v.to_i }
      end
    end

    def calculate_result!
      return nil unless valid?(:response)
      return nil if     response.nil?

      self.result_at = Time.current
      self.result = { "total_score" => 0, "needs_screen" => false }

      response.each do |r|
        self.result["total_score"]  += r["score"]
        self.result["needs_screen"] ||= r["score"] >= 2
      end

      self.save!
      self.result
    end

  end
end
