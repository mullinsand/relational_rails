class Chemical < ApplicationRecord
  belongs_to :storage_unit
  def self.flammable_chemicals(chemicals)
    chemicals.where(flammable: true)
  end
end