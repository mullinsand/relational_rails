# User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes:

require 'rails_helper'

RSpec.describe 'Chemicals index' do
  describe 'as a user' do
    describe 'US3: when I visit /chemicals, I see the attributes of each child record' do
      it 'lists all of the attributes of each storage unit' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
        methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
        propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
        acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
        potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: true)
        chemicals = [ethanol, methanol, propanol, acetone, potassium_oxalate]

        visit "/chemicals"

        chemicals.each do |chemical|
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
  end

  describe 'US8 and US9: When I visit show page, I see links to chemical index and storage index' do
    it 'has link to chemicals index' do
      visit "/chemicals"

      expect(page).to have_link("Chemicals Index")
      click_link("Chemicals Index")
      expect(current_path).to eq("/chemicals/")
    end
    
    it 'has link to storage units index' do
      visit "/chemicals"

      expect(page).to have_link("Storage Unit Index")
      click_link("Storage Unit Index")
      expect(current_path).to eq("/storage_units/")
    end
  end

  it 'has a link to edit chemical info on index page' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)

    visit "/chemicals"

    expect(page).to have_link("Edit #{ethanol.name}")
    click_link("Edit #{ethanol.name}")
    expect(current_path).to eq("/chemicals/#{ethanol.id}/edit")

    visit "/chemicals"
    
    expect(page).to have_link("Edit #{acetone.name}")
    click_link("Edit #{acetone.name}")
    expect(current_path).to eq("/chemicals/#{acetone.id}/edit")
  end

  it 'can be deleted' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)

    visit "/chemicals"
    expect(page).to have_content(ethanol.name)

    expect(page).to have_button("Delete #{ethanol.name}")
    click_button("Delete #{ethanol.name}")
    expect(current_path).to eq("/chemicals")

    visit "/chemicals"

    expect(page).to have_button("Delete #{methanol.name}")
    click_button("Delete #{methanol.name}")
    expect(current_path).to eq("/chemicals")

    visit "/chemicals"

    expect(page).to_not have_content(ethanol.name)
    expect(page).to_not have_content(methanol.name)
  end

  it 'only shows all flammable chemicals' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: false, storage_unit_id: 1)

    visit "/chemicals"

    expect(page).to have_content(ethanol.name)
    expect(page).to have_content(methanol.name)
    expect(page).to_not have_content(propanol.name)
  end

  it 'has link to add a new chemical' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    
    visit "/chemicals"

    expect(page).to have_link("Add new chemical")
    click_link("Add new chemical")
    expect(current_path).to eq("/chemicals/new")
  end
end