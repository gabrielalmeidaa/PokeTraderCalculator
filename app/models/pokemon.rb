class Pokemon
  include Mongoid::Document
  field :pokedex_id, type: Integer
  field :name, type: String
  field :base_experience, type: Integer
  field :_id, type: Integer, default: -> { pokedex_id }
end
