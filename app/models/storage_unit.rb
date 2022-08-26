class StorageUnit < ApplicationRecord
  has_many :chemicals, dependent: :destroy
  def self.sort_by_creation
    self.all.order(created_at: :desc)
  end

  def self.sort_by_chemicals
    self.all.sort_by do |storage_unit|
      -storage_unit.chemicals.count
    end
    # self.all.where()
  end

  def self.threshold(storage_unit, threshold_amount)
    storage_unit.chemicals.select { |chemical| chemical.amount > threshold_amount.to_f}
  end

  def self.search_exact(search_name)
    self.all.where(name: search_name)
  end
  
  def self.search_partial(search_name)
    self.all.where("name ILIKE ?", "%#{search_name}%")
  end
end