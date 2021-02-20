# frozen_string_literal: true

class TradeOffer
  include Mongoid::Document
  field :offer_total_experience, type: Integer
  embeds_many :pokemons

  validate :pokemon_offer_list_not_empty
  after_create :calculate_trade_offer_total_experience

  def calculate_trade_offer_total_experience
    self.offer_total_experience = pokemons.reduce(0) { |total_exp, pokemon| total_exp + pokemon.base_experience }
  end

  private

  def pokemon_offer_list_not_empty
    return unless pokemons.empty?

    errors.add(:pokemons, 'Pokemon list on trade offer should not be empty.')
  end
end
