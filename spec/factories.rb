FactoryGirl.define do

  factory :album do
    name Faker::Name.name
    img_url 'http://cockail.com'
  end

  factory :user do
    id 1
    name Faker::Name.name
    email 'tanay@tanay.com'
  end

  factory :artist do
    name Faker::Name.name
    url Faker::Internet.url
  end

  factory :artist2, class: Artist do
    name Faker::Name.name
    url Faker::Internet.url
  end

  factory :invalid_artist, class: Artist do
    name nil
    url nil
  end

  factory :valid_update_artist, class: Artist do
    name Faker::Name.name
    url Faker::Internet.url
  end

   factory :invalid_update_artist, class: Artist do
    name nil
    url nil
  end

  factory :song do
    id 1
    artist
    album
    name Faker::Name.name
  end

end
