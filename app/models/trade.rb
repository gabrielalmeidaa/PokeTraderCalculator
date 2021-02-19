class Trade
  include Mongoid::Document
  field :created_at, type: Time, default: Time.now
  field :fair_trade, type: Boolean
  embeds_many :trade_offers
end
