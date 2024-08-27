class CreateAssessments < ActiveRecord::Migration[6.1]
  def change
    # TODO: Rails 7 upgrade, switch key to an enumerated type

    create_table :assessments do |t|
      t.belongs_to :check_in, null: false
      t.string :key, null: false, comment: "the assessment key; 'PHQ9', etc."

      t.jsonb :response, comment: "the response values from the patient"
      t.datetime :response_at

      t.jsonb :result, comment: "the post-processed results from scoring the response"
      t.datetime :result_at

      t.timestamps
    end
  end
end
