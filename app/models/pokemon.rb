class Pokemon
  include Mongoid::Document
  field :name, type: String
  field :base_experience, type: Integer
end
