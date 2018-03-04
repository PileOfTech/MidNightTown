FactoryGirl.define do
  factory :track do
    name { Faker::Book.title }
    cover "https://pp.userapi.com/c543108/v543108085/345cf/SEaVGu60zaI.jpg"
    link { Faker::Internet.url }
    author_id { Faker::Number.between(1, 5) }
  end
end