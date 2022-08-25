# User Story 4, Child Show 

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes:

require 'rails_helper'

RSpec.describe 'Storage Unit show' do
  it 'shows all of the attributes of the selected chemical' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
    hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
    basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: 1)
    potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false, storage_unit_id: 3)
    

    visit "/chemicals/#{ethanol.id}"

    expect(page).to have_content(ethanol.name)
    expect(page).to have_content(ethanol.amount)
    expect(page).to have_content(ethanol.flammable)
    expect(page).to have_content(lab1.name)
    expect(page).to have_content(ethanol.created_at)
    expect(page).to have_content(ethanol.updated_at)
  end

  it 'has link to chemicals index' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)

    visit "/chemicals/#{ethanol.id}"

    expect(page).to have_link("Chemicals Index")
    click_link("Chemicals Index")
    expect(current_path).to eq("/chemicals/")
  end
  it 'has link to storage units index' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)

    visit "/chemicals/#{ethanol.id}"

    expect(page).to have_link("Storage Unit Index")
    click_link("Storage Unit Index")
    expect(current_path).to eq("/storage_units/")
  end

  it 'can be deleted' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)

    visit "/chemicals/#{ethanol.id}"
    expect(page).to have_content(ethanol.name)

    expect(page).to have_button("Delete #{ethanol.name}")
    click_button("Delete #{ethanol.name}")
    expect(current_path).to eq("/chemicals")

    visit "/chemicals/#{methanol.id}"

    expect(page).to have_button("Delete #{methanol.name}")
    click_button("Delete #{methanol.name}")
    expect(current_path).to eq("/chemicals")

    visit "/chemicals"

    expect(page).to_not have_content(ethanol.name)
    expect(page).to_not have_content(methanol.name)
  end
end