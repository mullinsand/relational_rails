class StorageUnit < ApplicationRecord
  has_many :chemicals, dependent: :destroy
  def self.sort_by_creation
    self.all.sort_by do |storage_unit|
      -storage_unit.created_at.to_i
    end
  end

  def self.sort_by_chemicals
    self.all.sort_by do |storage_unit|
      -storage_unit.chemicals.count
    end
  end

  def self.search_exact(search_name)
    self.all.select { |storage_unit| storage_unit.name == search_name }
  end
  
end