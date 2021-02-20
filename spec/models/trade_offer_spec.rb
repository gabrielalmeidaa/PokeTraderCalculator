# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradeOffer do
  let(:pokemons)  do
    [
      build(:pokemon, pokedex_id: 1, name: 'charizard', base_experience: 10),
      build(:pokemon, pokedex_id: 2, name: 'mewtwo', base_experience: 20),
      build(:pokemon, pokedex_id: 3, name: 'ghastly', base_experience: 100)
    ]
  end
  let(:subject) { described_class.new(offer_total_experience: 0, pokemons: pokemons) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with empty pokemon array' do
    subject.pokemons = []
    expect(subject).not_to be_valid
  end

  it 'is not valid with not Pokemon type object on pokemon array' do
    subject.pokemons = [build(:trade_offer, pokemons: pokemons)]
    expect(subject).not_to be_valid
  end

  it 'correctly calculates total_experience after object_creation' do
    subject.save
    expect(subject.offer_total_experience).to eq(130)
  end
end
