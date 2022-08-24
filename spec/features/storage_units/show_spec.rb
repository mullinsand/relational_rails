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
  end

  it 'shows a count of the number of children associated with this parent' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: 1)
    potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false, storage_unit_id: 3)

    visit "/storage_units/#{lab1.id}"
    expect(page).to have_content(4)
    visit "/storage_units/#{lab2.id}"
    expect(page).to have_content(1)
  end

  it 'has link to chemicals index' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)

    visit "/storage_units/#{lab1.id}"


    expect(page).to have_link("Chemicals Index")
  end
  it 'has link to storage units index' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    
    visit "/storage_units/#{lab1.id}"


    expect(page).to have_link("Storage Unit Index")
  end
end