# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_08_27_145209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: :cascade do |t|
    t.bigint "check_in_id", null: false
    t.string "key", null: false, comment: "the assessment key; 'PHQ9', etc."
    t.jsonb "response", comment: "the response values from the patient"
    t.jsonb "result", comment: "the post-processed results from scoring the response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["check_in_id"], name: "index_assessments_on_check_in_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.string "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
