# User Story 1, Parent Index 

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created

require 'rails_helper'

RSpec.describe 'Storage Unit index' do
  describe 'as a user' do
    it 'lists all of the names of each storage unit' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

      visit "/storage_units"

      expect(page).to have_content(lab1.name)
      expect(page).to have_content(lab2.name)
      expect(page).to have_content(hallway.name)
      expect(page).to have_content(basement.name)
    end

    it 'includes the timestamp of when each was created' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      sleep(1)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      sleep(1)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      sleep(1)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

      visit "/storage_units"

      expect(page).to have_content(lab1.created_at)
      expect(page).to have_content(lab2.created_at)
      expect(page).to have_content(hallway.created_at)
      expect(page).to have_content(basement.created_at)
    end

    it 'has link to chemicals index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
  
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
  
      visit "/storage_units"
  
      expect(page).to have_link("Chemicals Index")
      click_link("Chemicals Index")
      expect(current_path).to eq("/chemicals/")
    end
    it 'has link to storage units index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
  
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
  
      visit "/storage_units"
  
      expect(page).to have_link("Storage Unit Index")
      click_link("Storage Unit Index")
      expect(current_path).to eq("/storage_units/")
    end

    it 'has link to create new storage unit record' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
  
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
  
      visit "/storage_units"
  
      expect(page).to have_link("Add new storage unit")
      click_link("Add new storage unit")
      expect(current_path).to eq("/storage_units/new")
    end
  end


end