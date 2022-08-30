# User Story 4, Child Show 

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes:

require 'rails_helper'

RSpec.describe 'Storage Unit show' do
  describe 'as a user' do
    describe 'US4: when I visit /chemicals/:id, I see the child with that ids attributes' do
      it 'shows all of the attributes of the selected chemical' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
        basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
        propanol = hallway.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
        potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false)
        

        visit "/chemicals/#{ethanol.id}"

        expect(page).to have_content(ethanol.name)
        expect(page).to have_content(ethanol.amount)
        expect(page).to have_content(ethanol.flammable)
        expect(page).to have_content(lab1.name)
        expect(page).to have_content(ethanol.created_at)
        expect(page).to have_content(ethanol.updated_at)

        visit "/chemicals/#{propanol.id}"

        expect(page).to have_content(propanol.name)
        expect(page).to have_content(propanol.amount)
        expect(page).to have_content(propanol.flammable)
        expect(page).to have_content(hallway.name)
        expect(page).to have_content(propanol.created_at)
        expect(page).to have_content(propanol.updated_at)
      end
    end
  end

  describe 'US8 and US9: When I visit show page, I see links to chemical index and storage index' do
    it 'has link to chemicals index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)

      visit "/chemicals/#{ethanol.id}"

      expect(page).to have_link("Chemicals Index")
      click_link("Chemicals Index")
      expect(current_path).to eq("/chemicals/")
    end

    it 'has link to storage units index' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)

      visit "/chemicals/#{ethanol.id}"

      expect(page).to have_link("Storage Unit Index")
      click_link("Storage Unit Index")
      expect(current_path).to eq("/storage_units/")
    end
  end

  describe 'US20: Child delete' do
    it 'can be deleted' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = hallway.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)

      visit "/chemicals/#{propanol.id}"

      expect(page).to have_content(propanol.name)
      expect(page).to have_button("Delete #{propanol.name}")
      click_button("Delete #{propanol.name}")
      expect(current_path).to eq("/chemicals")

      visit "/chemicals"
      expect(page).to_not have_content(propanol.name)
      expect(page).to have_content(methanol.name)

      visit "/chemicals/#{methanol.id}"

      expect(page).to have_button("Delete #{methanol.name}")
      click_button("Delete #{methanol.name}")
      expect(current_path).to eq("/chemicals")

      visit "/chemicals"

      expect(page).to_not have_content(propanol.name)
      expect(page).to_not have_content(methanol.name)
      expect(page).to have_content(acetone.name)
    end
  end
end