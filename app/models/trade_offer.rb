# frozen_string_literal: true

class TradeOffer
  include Mongoid::Document
  has_and_belongs_to_many :pokemons, inverse_of: nil

  embeds_many :pokemons
  validate :pokemon_offer_list_not_empty
  validate :only_pokemon_instances_on_pokemon_array

  def offer_total_experience
    pokemons.reduce(0) { |total_exp, pokemon| total_exp + pokemon.base_experience }
  end

  private

  def pokemon_offer_list_not_empty
    return unless pokemons.empty?

    errors.add(:pokemons, 'Pokemon list on trade offer should not be empty.')
  end

  def only_pokemon_instances_on_pokemon_array
    return unless pokemons.select { |pokemon| (pokemon.instance_of? Pokemon) }.empty?

    errors.add(:pokemons, 'Something on pokemon array is not an instance of Pokemon')
  end
end
