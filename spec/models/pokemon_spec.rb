require 'rails_helper'

RSpec.describe Pokemon do
  let(:subject) { described_class.new(pokedex_id: 1, name: 'fake pokemon', base_experience: 10) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name attribute' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without base_experience attribute' do
    subject.base_experience = nil
    expect(subject).to_not be_valid
  end

  it 'has Integer attribute base_experience' do
    subject.base_experience = "i'm a string"
    is_expected.to have_field(:base_experience).of_type(Integer)
  end

  it 'does not save new pokemon with same pokedex_id' do
    subject.save
    pokemon_with_same_id = build(:pokemon, pokedex_id: 1)
    expect(pokemon_with_same_id).to_not be_valid  
  end

end
