# User Story 2, Parent Show 

# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes:
# - data from each column that is on the parent table

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
end