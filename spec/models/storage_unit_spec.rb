# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created

require "rails_helper"

RSpec.describe 'Storage unit model' do
  describe '#sort_by_creation' do
    it 'sorts storage units by creation with newest record first' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      sleep(1)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      expect(StorageUnit.sort_by_creation).to eq([lab2, lab1])
      sleep(1)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      sleep(1)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
      expect(StorageUnit.sort_by_creation).to eq([basement, hallway, lab2, lab1])
    end
  end

  describe '#sort by chemicals' do
    it 'sorts storage units by chemicals count (high to low)' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

      ethanol = lab2.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab2.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false)

      expect(StorageUnit.sort_by_chemicals).to eq([lab2, lab1])
    end
  end

  describe '#search exact' do
    it 'searches all names and returns the ones that match the search exactly' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
      
      expect(StorageUnit.search_exact("lab1")).to eq([lab1])
      expect(StorageUnit.search_exact("lab2")).to eq([lab2])
    end
  end

  describe '#search partial' do
    it 'searches all names and returns the ones that match the search exactly' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
      
      expect(StorageUnit.search_partial("lab")).to eq([lab1, lab2])
      expect(StorageUnit.search_partial("hall")).to eq([hallway])
      expect(StorageUnit.search_partial("a")).to eq([lab1, lab2, hallway, basement])

    end
  end


end