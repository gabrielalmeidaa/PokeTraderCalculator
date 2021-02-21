# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradeOffer do
  let(:pokemons)  do
    [
      create(:pokemon, pokedex_id: 1, name: 'charizard', base_experience: 10),
      create(:pokemon, pokedex_id: 2, name: 'mewtwo', base_experience: 20),
      create(:pokemon, pokedex_id: 3, name: 'ghastly', base_experience: 100)
    ]
  end

  let(:subject) { described_class.new(pokemons: pokemons) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with empty pokemon array' do
    subject.pokemons = []
    expect(subject).not_to be_valid
  end

  it 'is not valid with pokemon offer array longer than limit' do
    4.times do
      subject.pokemons.append(build(:pokemon))
    end
    expect(subject).not_to be_valid
  end

  it 'is not valid with not Pokemon type object on pokemon array' do
    subject.pokemons = [build(:trade_offer, pokemons: pokemons)]
    expect(subject).not_to be_valid
  end

  describe '.offer_total_experience' do
    it 'correctly calculates total_experience' do
      expect(subject.offer_total_experience).to eq(130)
    end

    it 'correctly calculates total_experience with repeated pokemon on list' do
      subject.pokemons.append(pokemons.last)
      expect(subject.offer_total_experience).to eq(230)
    end
  end
end
