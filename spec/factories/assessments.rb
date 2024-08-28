FactoryBot.define do
  factory :assessment do
    check_in

    factory :assessment_phq, class: Assessment::PHQ do
      key { "PHQ" }
    end
  end
end
