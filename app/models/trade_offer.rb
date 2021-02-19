class TradeOffer
  include Mongoid::Document
  field :offer_total_experience, type: Integer
  embeds_many :pokemons
end
