FactoryGirl.define do
  factory :country_play_list do
    track_id { Faker::Number.between(1, 10) }
    score { Faker::Number.between(10, 999) }
    country_id { Faker::Number.between(1, 10) }
    year { Faker::Date.between(20.years.ago, Date.today).to_s[0..3]
 }
  end
end