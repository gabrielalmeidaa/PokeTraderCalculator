# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trade do
  let(:pokemons) do
    [
      build(:pokemon, pokedex_id: 1, name: 'charizard', base_experience: 10),
      build(:pokemon, pokedex_id: 2, name: 'mewtwo', base_experience: 20),
      build(:pokemon, pokedex_id: 3, name: 'ghastly', base_experience: 100)
    ]
  end
  let(:trade_offers) do
    [
      build(:trade_offer, pokemons: [pokemons[2]]),
      build(:trade_offer, pokemons: [pokemons[0], pokemons[1]])
    ]
  end

  let(:subject) { described_class.new(trade_offers: trade_offers) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with an incorrect amount of trade offers' do
    subject.trade_offers.append(build(:trade_offer, pokemons: pokemons))
    expect(subject).not_to be_valid
  end

  describe '.fair_trade?' do
    it 'returns false on unfair trade' do
      trade_offers.map(&:save)
      expect(subject.fair_trade?).to be false
    end

    it 'returns true on fair trade' do
      fair_trade_offers = [
        create(:trade_offer, pokemons: [pokemons[2], pokemons[1]]),
        create(:trade_offer, pokemons: [pokemons[2], pokemons[0]])
      ]
      subject.trade_offers = fair_trade_offers
      expect(subject.fair_trade?).to be false
    end
  end
end
