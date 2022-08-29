class StorageUnit < ApplicationRecord
  has_many :chemicals, dependent: :destroy

  validates :name, presence: true
  validates :size, presence: true
  validates :fireproof, inclusion: [true, false]


  def self.sort_by_creation
    self.all.order(created_at: :desc)
  end

  def self.sort_by_chemicals
    self.select("storage_units.*, coalesce(count(storage_unit_id), 0) as chemical_count").left_joins(:chemicals).group(:id).order("chemical_count desc")
  end

  def self.threshold(storage_unit, threshold_amount)
    storage_unit.chemicals.where("amount > #{threshold_amount}")
  end

  def self.search_exact(search_name)
    self.all.where(name: search_name)
  end
  
  def self.search_partial(search_name)
    self.all.where("name ILIKE ?", "%#{search_name}%")
  end

  def chemicals_count
    self.chemicals.count
  end
end