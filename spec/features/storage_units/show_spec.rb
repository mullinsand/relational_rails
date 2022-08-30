# User Story 2, Parent Show 

# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes:
# - data from each column that is on the parent table

# User Story 7, Parent Child Count

# As a visitor
# When I visit a parent's show page
# I see a count of the number of children associated with this parent

require 'rails_helper'

RSpec.describe 'Storage Unit show' do
  describe 'US2: when I visit /storage_units/:id, I see that parent and all the parents attributes' do
    it 'shows all of the attributes of the selected storage unit' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

      visit "/storage_units/#{lab1.id}"

      expect(page).to have_content(lab1.name)
      expect(page).to have_content(lab1.size)
      expect(page).to have_content(lab1.fireproof)
      expect(page).to have_content(lab1.created_at)
      expect(page).to have_content(lab1.updated_at)

      visit "/storage_units/#{hallway.id}"

      expect(page).to have_content(hallway.name)
      expect(page).to have_content(hallway.size)
      expect(page).to have_content(hallway.fireproof)
      expect(page).to have_content(hallway.created_at)
      expect(page).to have_content(hallway.updated_at)
    end
  end

  describe 'US7: when I visit a parents show page, I see a count of the number of chemicals associated with this storage_unit' do
    it 'shows a count of the number of children associated with this parent' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false)

      visit "/storage_units/#{lab1.id}"
      expect(page).to have_content(4)
      visit "/storage_units/#{lab2.id}"
      expect(page).to have_content(1)
      visit "/storage_units/#{hallway.id}"
      expect(page).to have_content(0)
    end
  end

  describe 'US8 and US9: When I visit show page, I see links to chemical index and storage index' do
    it 'has link to chemicals index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

      visit "/storage_units/#{lab1.id}"


      expect(page).to have_link("Chemicals Index")
      click_link("Chemicals Index")
      expect(current_path).to eq("/chemicals/")
    end
    it 'has link to storage units index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      
      visit "/storage_units/#{lab1.id}"


      expect(page).to have_link("Storage Unit Index")
      click_link("Storage Unit Index")
      expect(current_path).to eq("/storage_units/")
    end
  end

  describe 'US10: When I visit show page, I see a link that takes me to that storage_units chemical list' do
    it 'has link to chemicals in that storage' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      
      visit "/storage_units/#{lab1.id}"


      expect(page).to have_link("Chemicals")
      click_link("Chemicals")
      expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals")
    end
  end
  describe 'US19: Parent delete' do
    it 'can be deleted' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)

      visit "/storage_units/#{lab1.id}"
      expect(page).to have_content(lab1.name)

      expect(page).to have_button("Delete #{lab1.name}")
      click_button("Delete #{lab1.name}")
      expect(current_path).to eq("/storage_units")

      visit "/storage_units"

      expect(page).to_not have_content(lab1.name)
      expect(page).to have_content(lab2.name)

    end

    it 'deletes all chemicals inside storage unit when storage unit is deleted' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)

      visit "/storage_units/#{lab1.id}"
      click_button("Delete #{lab1.name}")
      expect(current_path).to eq("/storage_units")

      visit "/chemicals"

      expect(page).to_not have_content(ethanol.name)
      expect(page).to_not have_content(methanol.name)
      expect(page).to_not have_content(propanol.name)
      expect(page).to_not have_content(acetone.name)
      expect(page).to have_content(potassium_oxalate.name)
    end
  end
end