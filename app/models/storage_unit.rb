class StorageUnit < ApplicationRecord
  has_many :chemicals, dependent: :destroy

  validates :name, presence: true
  validates :size, presence: true
  validates :fireproof, inclusion: [true, false]


  def self.sort_by_creation
    order(created_at: :desc)
  end

  def self.sort_by_chemicals
    select("storage_units.*, coalesce(count(storage_unit_id), 0) as chemical_count").left_joins(:chemicals).group(:id).order("chemical_count desc")
  end

  def threshold(threshold_amount)
    chemicals.where("amount > #{threshold_amount}")
  end

  def chemicals_count
    chemicals.count
  end

  def self.build_options_array
    pluck(:name, :id)
  end
end