FactoryBot.define do
  factory :user do
    username { Faker::StarWars.character }
    email 'foo@bar.com'
    password 'foobar' #surely we're not testing all users with the same email and password? fix this
  end
end