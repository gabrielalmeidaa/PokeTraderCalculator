# frozen_string_literal: true

class PokemonImportJob < ActiveJob::Base
  queue_as :default
  POKEMON_PER_REQUEST = 50

  def import_pokemon(identifier)
    pokemon = PokemonService.get_pokemon(identifier)
    if pokemon
      Pokemon.create(pokedex_id: pokemon.id,
                     base_experience: pokemon.base_experience,
                     name: pokemon.name)
    else
      ArgumentError("Couldn't find pokémon with given name or id.")
    end
  end

  def bulk_pokemon_import(offset = 0)
    pokemon_list = PokemonService.get_pokemon_list(offset, POKEMON_PER_REQUEST)
    pokemon_list.results.each do |pokemon|
      import_pokemon(pokemon.name)
    end
    bulk_pokemon_import(offset + POKEMON_PER_REQUEST) if pokemon_list.next_url
  end

  def perform(name = nil, id = nil)
    puts 'Starting pokemon import process...'
    pokemon_request_identifier = name or id
    if pokemon_request_identifier
      import_pokemon(pokemon_request_identifier)
    else
      bulk_pokemon_import
    end
    puts 'Done!'
  end
end
