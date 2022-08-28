class Chemical < ApplicationRecord
  belongs_to :storage_unit, foreign_key: "storage_unit_id"

  validates :name, presence: true
  validates :amount, presence: true
  validates :flammable, inclusion: [true, false]
  validates :storage_unit_id, presence: true

  def self.flammable_chemicals(chemicals)
    chemicals.where(flammable: true)
  end
end