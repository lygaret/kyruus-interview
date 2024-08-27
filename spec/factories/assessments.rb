FactoryBot.define do
  factory :assessment do
    check_in

    factory :assessment_phq do
      key { "PHQ" }
    end
  end
end
