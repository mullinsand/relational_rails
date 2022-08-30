# User Story 5, Parent Children Index 

# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes:

require 'rails_helper'

RSpec.describe 'Storage Unit chemicals index' do
  describe 'as a visitor' do
    describe 'US 5: when I visit /storage_units/:storage_unit_id/chemicals, I see each chemical associated with that storage_unit and their attributes' do
        it 'has a all the chemicals associated with the storage_unit' do
          lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
          lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
  
          ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
          methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
          propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
          acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
          potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)
          lab1_chemicals = [ethanol, methanol, propanol, acetone]
          lab2_chemicals = [potassium_oxalate]

          visit "/storage_units/#{lab1.id}/chemicals"
        
          lab1_chemicals.each do |chemical|
            within "#chemical_#{chemical.id}" do
              expect(page).to have_content(chemical.name)
              expect(page).to have_content(chemical.flammable)
              expect(page).to have_content(chemical.amount)
              expect(page).to have_content(chemical.updated_at)
              expect(page).to have_content(chemical.created_at)
            end
          end

          visit "/storage_units/#{lab2.id}/chemicals"
          lab2_chemicals.each do |chemical|
            within "#chemical_#{chemical.id}" do
              expect(page).to have_content(chemical.name)
              expect(page).to have_content(chemical.flammable)
              expect(page).to have_content(chemical.amount)
              expect(page).to have_content(chemical.updated_at)
              expect(page).to have_content(chemical.created_at)
            end
          end
      end
    end 

    describe 'US8 and US9: When I visit show page, I see links to chemical index and storage index' do
      it 'has link to chemicals index' do

        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)

        visit "/storage_units/#{lab1.id}/chemicals"


        expect(page).to have_link("Chemicals Index")
        click_link("Chemicals Index")
        expect(current_path).to eq("/chemicals/")
      end

      it 'has link to storage units index' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        
        visit "/storage_units/#{lab1.id}/chemicals"
  
        expect(page).to have_link("Storage Unit Index")
        click_link("Storage Unit Index")
        expect(current_path).to eq("/storage_units/")
      end
    end

    it 'links to each chemicals show page' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
      potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)
      lab1_chemicals = [ethanol, methanol, propanol, acetone]
      lab2_chemicals = [potassium_oxalate]

      lab1_chemicals.each do |chemical|
          visit "/storage_units/#{lab1.id}/chemicals"
          click_on chemical.name
          expect(current_path).to eq("/chemicals/#{chemical.id}")
      end

      lab2_chemicals.each do |chemical|
        visit "/storage_units/#{lab2.id}/chemicals"
        click_on chemical.name
        expect(current_path).to eq("/chemicals/#{chemical.id}")
      end

    end

    describe 'US16: Sort Parents children in alpha order by name' do
      it 'has a link to sort by alphabetical order' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
        propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)
        potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)

        visit "/storage_units/#{lab1.id}/chemicals"

        expect(page).to have_link("Sort in Alphabetical Order")
      end

      it 'reloads page upon clicking alphabetical order link with chemicals in alpha order' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
        potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)

        visit "/storage_units/#{lab1.id}/chemicals"

        expect("ethanol").to appear_before("acetone", only_text: true)
        expect("propanol").to appear_before("methanol")
        click_link("Sort in Alphabetical Order")

        expect("acetone").to appear_before("ethanol", only_text: true)
        expect("methanol").to appear_before("propanol")
      end
    end

    it 'has a link to edit chemical info on index page' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
      acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)

      visit "/storage_units/#{lab1.id}/chemicals"

      expect(page).to have_link("Edit #{ethanol.name}")
      click_link("Edit #{ethanol.name}")
      expect(current_path).to eq("/chemicals/#{ethanol.id}/edit")

      visit "/storage_units/#{lab1.id}/chemicals"
      
      expect(page).to have_link("Edit #{acetone.name}")
      click_link("Edit #{acetone.name}")
      expect(current_path).to eq("/chemicals/#{acetone.id}/edit")
    end

    describe 'US 21: Display records over a given threshold' do
      it 'has a form to display chemicals with more than XX grams' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
        propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)

        visit "/storage_units/#{lab1.id}/chemicals"

        fill_in(:threshold_search, with: 750)
        click_button("Only returns chemicals with more than this amount in grams")

        expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals")
      end

      it 'after clicking submit button, only returns records with more than XX grams' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 750.00, flammable: true)
        propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
        potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)

        visit "/storage_units/#{lab1.id}/chemicals"

        fill_in(:threshold_search, with: 750)
        click_button("Only returns chemicals with more than this amount in grams")

        expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals")
        expect(page).to_not have_content(methanol.name)
        expect(page).to_not have_content(ethanol.name)
        expect(page).to have_content(propanol.name)
        expect(page).to have_content(acetone.name)
      end
    end
  end
end