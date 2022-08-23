# User Story 1, Parent Index 

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

require 'rails_helper'

RSpec.describe 'Storage Unit index' do
  it 'shows all of the names of each storage unit' do
    lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
    hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
    basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)

    visit "/storage_units"

    expect(page).to have_content(lab1.name)
    expect(page).to have_content(lab2.name)
    expect(page).to have_content(hallway.name)
    expect(page).to have_content(basement.name)
  end
end