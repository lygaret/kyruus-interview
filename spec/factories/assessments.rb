FactoryBot.define do
  factory :assessment do
    check_in

    factory :assessment_phq9 do
      key { "PHQ9" }
    end
  end
end
