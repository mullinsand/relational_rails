# User Story 1, Parent Index 

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

require 'rails_helper'

RSpec.describe 'Storage Unit index' do
  it 'shows all of the names of each storage unit' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 6.00, flammable: true)

    visit "/storage_units/#{lab1.id}/chemicals"

    expect(page).to have_content(ethanol.name)
    expect(page).to have_content(ethanol.amount)
    expect(page).to have_content(ethanol.flammable)

    expect(page).to have_content(methanol.name)
    expect(page).to have_content(methanol.amount)
    expect(page).to have_content(methanol.flammable)
  end

  it 'links to each chemicals show page' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 6.00, flammable: true)

    visit "/storage_units/#{lab1.id}/chemicals"

    click_on ethanol.name
    expect(current_path).to eq("/chemicals/#{ethanol.id}")
  end
end