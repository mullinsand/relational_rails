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

  it 'has link to chemicals index' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)

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

  it 'has link to add a new chemical' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    
    visit "/storage_units/#{lab1.id}/chemicals"

    expect(page).to have_link("Add New Chemical to #{lab1.name}")
    click_link("Add New Chemical to #{lab1.name}")
    expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals/new")
  end

  it 'has a link to sort by alphabetical order' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)

    visit "/storage_units/#{lab1.id}/chemicals"

    expect(page).to have_link("Sort in Alphabetical Order")
  end

  it 'reloads page upon clicking alphabetical order link with chemicals in alpha order' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)

    visit "/storage_units/#{lab1.id}/chemicals"

    expect("ethanol").to appear_before("acetone", only_text: true)

    click_link("Sort in Alphabetical Order")

    expect("acetone").to appear_before("ethanol", only_text: true)
  end

  it 'has a link to edit chemical info on index page' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)

    visit "/storage_units/#{lab1.id}/chemicals"

    expect(page).to have_link("Edit #{ethanol.name}")
    click_link("Edit #{ethanol.name}")
    expect(current_path).to eq("/chemicals/#{ethanol.id}/edit")

    visit "/storage_units/#{lab1.id}/chemicals"
    
    expect(page).to have_link("Edit #{acetone.name}")
    click_link("Edit #{acetone.name}")
    expect(current_path).to eq("/chemicals/#{acetone.id}/edit")
  end

  it 'has a form to display chemicals with more than XX grams' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
    methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: lab1.id)
    propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: lab1.id)
    acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: lab1.id)

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