# frozen_string_literal: true

require 'poke-api-v2'

class PokemonService
  def self.get_pokemon_list(offset, limit)
    PokeApi.get(pokemon: { offset: offset, limit: limit })
  end

  def self.get_pokemon(identifier)
    PokeApi.get(pokemon: identifier)
  end
end
