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
    describe 'US1: when I visit /storage_units, I see the name of each parent record' do
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
          end
        end
      end 
    end

    describe 'US6: when I visit /storage_units' do
      it 'includes the timestamp of when each was created' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        sleep(1)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        sleep(1)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        sleep(1)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
        storage_units = [lab1, lab2, hallway, basement]
        visit "/storage_units"

        storage_units.each do |storage_unit|
          within "#storage_unit_#{storage_unit.id}" do
            expect(page).to have_content(storage_unit.created_at)
          end
        end
      end

      it 'sorts the records with most recent appearing first' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        sleep(1)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        sleep(1)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        sleep(1)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
        storage_units = [lab1, lab2, hallway, basement]

        visit "/storage_units"

        expect(lab2.name).to appear_before(lab1.name)
        expect(basement.name).to appear_before(hallway.name)

        lab3 = StorageUnit.create!(name: 'lab3', size: 2.0, fireproof: true)

        visit "/storage_units"

        expect(lab3.name).to appear_before(basement.name)
      end
    end

    describe 'US8 and US9: When I visit show page, I see links to chemical index and storage index' do
      it 'has link to chemicals index' do
 
        visit "/storage_units"
    
        expect(page).to have_link("Chemicals Index")
        click_link("Chemicals Index")
        expect(current_path).to eq("/chemicals/")
      end

      it 'has link to storage units index' do
    
        visit "/storage_units"
    
        expect(page).to have_link("Storage Unit Index")
        click_link("Storage Unit Index")
        expect(current_path).to eq("/storage_units/")
      end
    end


    describe 'US17: Parent update from parent index page' do
      it 'has a link to edit storage unit info on index page' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
        storage_units = [lab1, lab2, hallway, basement]

        visit "/storage_units"

        storage_units.each do |storage_unit|
          within "#storage_unit_#{storage_unit.id}" do
            expect(page).to have_link("Edit #{storage_unit.name}")
            click_link("Edit #{storage_unit.name}")
            expect(current_path).to eq("/storage_units/#{storage_unit.id}/edit")
            visit "/storage_units"
          end
        end
      end
    end

    describe 'US19: Parent delete from Parent Index page' do
      it 'can be deleted' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)

        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
        propanol = lab2.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        storage_units = [lab1, lab2, hallway]
        visit "/storage_units/"
        storage_units.each do |storage_unit|
          within "#storage_unit_#{storage_unit.id}" do
            expect(page).to have_content(storage_unit.name)
            expect(page).to have_button("Delete #{storage_unit.name}")
            click_button("Delete #{storage_unit.name}")
            expect(current_path).to eq("/storage_units")
          end
          expect(page).to_not have_content(storage_unit.name)
        end
      end
    end
  
    describe 'EX1: Sort Parents by Number of Children' do
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
    end

    describe ' EX2: search by name (exact)' do
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

      it 'differentiates between lab1 and lab2' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

        visit "/storage_units/"

        fill_in :search_exact, with: "lab1"
        click_button "Search (exact)"

        expect(page).to have_content(lab1.name)
        expect(page).to_not have_content(lab2.name)
      end
    end

    describe 'EX3: search by name (partial)' do
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

      it 'only needs a single letter' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

        visit "/storage_units/"

        fill_in :search_partial, with: "b"
        click_button "Search (partial)"

        expect(page).to_not have_content(hallway.name)
        expect(page).to have_content(lab1.name)
        expect(page).to have_content(lab2.name)
        expect(page).to have_content(basement.name)
      end
    end
  end
end