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
      storage_units = [lab1, lab2, hallway, basement]
      visit "/storage_units"

      storage_units.each do |storage_unit|
        within "#storage_unit_#{storage_unit.id}" do
          expect(page).to have_content(storage_unit.name)
          expect(page).to have_content(storage_unit.created_at)
        end
      end
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

      expect(lab2.name).to appear_before(lab1.name)
      expect(basement.name).to appear_before(hallway.name)
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

    it 'has a link to edit storage unit info on index page' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

      visit "/storage_units"

      expect(page).to have_link("Edit #{lab1.name}")
      click_link("Edit #{lab1.name}")
      expect(current_path).to eq("/storage_units/#{lab1.id}/edit")

      visit "/storage_units"
      
      expect(page).to have_link("Edit #{hallway.name}")
      click_link("Edit #{hallway.name}")
      expect(current_path).to eq("/storage_units/#{hallway.id}/edit")
    end

    it 'can be deleted' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
  
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
  
      visit "/storage_units"
      expect(page).to have_content(lab1.name)
  
      expect(page).to have_button("Delete #{lab1.name}")
      click_button("Delete #{lab1.name}")
      expect(current_path).to eq("/storage_units")
  
      visit "/storage_units"
  
      expect(page).to_not have_content(lab1.name)
    end
  
    it 'deletes all chemicals inside storage unit when storage unit is deleted' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
  
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
  
      visit "/storage_units/"
      click_button("Delete #{lab1.name}")
      expect(current_path).to eq("/storage_units")
  
      visit "/chemicals"
  
      expect(page).to_not have_content(ethanol.name)
      expect(page).to_not have_content(methanol.name)
      expect(page).to_not have_content(propanol.name)
    end

    it 'has link to sort all storage units by number of chemicals' do
      visit "/storage_units/"
      expect(page).to have_link("Sort by chemical count")
    end

    it 'sorts all storage units by chemical count' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)


      ethanol = lab2.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab2.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab2.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab2.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = basement.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false)

      visit "/storage_units/"
      click_link("Sort by chemical count")

      expect(lab2.name).to appear_before(lab1.name)
      expect(lab2.name).to appear_before(basement.name)
      expect(basement.name).to appear_before(lab1.name)
    end

    describe 'search by name (exact)' do
      it 'has text box to filter by keyword' do
        visit "/storage_units/"

        fill_in :search_exact, with: "hallway"
        click_button "Search (exact)"
      end

      it 'displays records that contain exact match on page when form is submitted' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

        visit "/storage_units/"

        fill_in :search_exact, with: "hallway"
        click_button "Search (exact)"

        expect(page).to have_content(hallway.name)
        expect(page).to_not have_content(lab1.name)
        expect(page).to_not have_content(lab2.name)
        expect(page).to_not have_content(basement.name)
      end
    end

    describe 'search by name (partial)' do
      it 'has text box to filter by keyword' do
        visit "/storage_units/"

        fill_in :search_partial, with: "lab"
        click_button "Search (partial)"
      end

      it 'displays records that contain partial match on page when form is submitted' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

        visit "/storage_units/"

        fill_in :search_partial, with: "lab"
        click_button "Search (partial)"

        expect(page).to_not have_content(hallway.name)
        expect(page).to have_content(lab1.name)
        expect(page).to have_content(lab2.name)
        expect(page).to_not have_content(basement.name)
      end
    end
  end


end