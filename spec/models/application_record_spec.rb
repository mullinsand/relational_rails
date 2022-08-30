require 'rails_helper'

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