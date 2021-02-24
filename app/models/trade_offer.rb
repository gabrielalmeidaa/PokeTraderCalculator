# frozen_string_literal: true

class TradeOffer
  include Mongoid::Document
  POKEMON_PER_TRADE_LIMIT = 6

  has_and_belongs_to_many :pokemons, inverse_of: nil

  embeds_many :pokemons
  validate :pokemon_offer_list_not_empty
  validate :pokemon_offer_list_does_not_surpass_pokemon_limit
  validate :only_pokemon_instances_on_pokemon_array

  def build_from_pokemon_ids(pokemon_ids)
    TradeOffer.new(pokemons: pokemon_ids.map { |id| Pokemon.get_by_id(id.to_i) })
  end

  def offer_total_experience
    pokemons.reduce(0) { |total_exp, pokemon| total_exp + pokemon.base_experience }
  end

  private

  def pokemon_offer_list_does_not_surpass_pokemon_limit
    return unless pokemons.length > POKEMON_PER_TRADE_LIMIT

    errors.add(:pokemons, "Pokemon offer list should not be greater than #{POKEMON_PER_TRADE_LIMIT}")
  end

  def pokemon_offer_list_not_empty
    return unless pokemons.empty?

    errors.add(:pokemons, 'Pokemon list on trade offer should not be empty.')
  end

  def only_pokemon_instances_on_pokemon_array
    return unless pokemons.select { |pokemon| (pokemon.instance_of? Pokemon) }.empty?

    errors.add(:pokemons, 'Something on pokemon array is not an instance of Pokemon')
  end
end
