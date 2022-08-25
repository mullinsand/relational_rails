class StorageUnit < ApplicationRecord
  has_many :chemicals, dependent: :destroy
  def self.sort_by_creation
    self.all.sort_by do |storage_unit|
      -storage_unit.created_at.to_i
    end
  end
end