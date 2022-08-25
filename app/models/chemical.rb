class Chemical < ApplicationRecord
  belongs_to :storage_unit
  def flammable_chemicals(chemicals)
    chemicals.select { |chemical| chemical.flammable == true }
  end
end