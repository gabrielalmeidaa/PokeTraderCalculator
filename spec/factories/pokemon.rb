require 'faker'

FactoryBot.define do
  factory :pokemon do
    name {Faker::Name.name}
    pokedex_id {1}
    base_experience {0}
  end
end