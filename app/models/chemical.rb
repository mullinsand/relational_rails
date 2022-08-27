class Chemical < ApplicationRecord
  belongs_to :storage_unit, foreign_key: "storage_unit_id"

  def self.flammable_chemicals(chemicals)
    chemicals.where(flammable: true)
  end
end