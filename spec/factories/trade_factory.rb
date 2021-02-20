# frozen_string_literal: true

FactoryBot.define do
  factory :trade do
    created_at { Time.now }
    trade_offers { [] }
  end
end
