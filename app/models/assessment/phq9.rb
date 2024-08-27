class Assessment
  class PHQ9 < Assessment

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

  end
end
