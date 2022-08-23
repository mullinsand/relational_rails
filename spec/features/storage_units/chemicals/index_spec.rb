# User Story 5, Parent Children Index 

# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes:

require 'rails_helper'

RSpec.describe 'Storage Unit chemicals index' do
  it 'shows all of the names of the chemicals for each storage unit' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 6.00, flammable: true)

    visit "/storage_units/#{lab1.id}/chemicals"

    expect(page).to have_content(ethanol.name)
    expect(page).to have_content(methanol.name)
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