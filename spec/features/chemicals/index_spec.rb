# User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes:

require 'rails_helper'

RSpec.describe 'Chemicals index' do
  it 'lists all of the names of each Chemical' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true)
    potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false)
  

    visit "/chemicals"

    expect(page).to have_content(ethanol.name)
    expect(page).to have_content(ethanol.amount)
    expect(page).to have_content(ethanol.flammable)
    expect(page).to have_content(potassium_oxalate.name)
    expect(page).to have_content(potassium_oxalate.flammable)
  end

  it 'has link to chemicals index' do
    visit "/chemicals"

    expect(page).to have_link("Chemicals Index")
  end
  it 'has link to storage units index' do
    visit "/chemicals"

    expect(page).to have_link("Storage Unit Index")
  end
end