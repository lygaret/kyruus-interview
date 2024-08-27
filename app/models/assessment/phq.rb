class Assessment
  class PHQ < Assessment

    PROMPT = <<~PROMPT
      Over the past 2 weeks, how often have you been bothered
      by any of the following problems?
    PROMPT

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

    def prompt    = PROMPT
    def questions = QUESTIONS

    def response_options
      RESPONSES.map { |r| [ r[:label], r[:score] ] }
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
