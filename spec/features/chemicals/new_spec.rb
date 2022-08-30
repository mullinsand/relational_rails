require 'rails_helper'

RSpec.describe 'chemical new' do
  describe 'US13: form for creating new chemical record' do
    describe 'as a user' do
      it 'when I visit storage_unit chemicals index page, has link to add a new chemical' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 3.00, flammable: true)
        
        visit "/storage_units/#{lab1.id}/chemicals"
  
        expect(page).to have_link("Add New Chemical to #{lab1.name}")
        click_link("Add New Chemical to #{lab1.name}")
        expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals/new")
      end

      it 'has a form to submit chemical attributes' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        visit "/storage_units/#{lab1.id}/chemicals/new"
        #storage is prefilled
        expect(page).to have_content(lab1.name)

        fill_in('name', with: 'isopropanol')
        fill_in('amount', with: 300.00)
        choose('flammable', with: true)
        select(lab1.name, from: "Storage Unit")
        click_button('Create Chemical')
        
        new_chemical = Chemical.last
        expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals")
        within "#chemical_#{new_chemical.id}" do
          expect(page).to have_content(new_chemical.name)
          expect(page).to have_content(new_chemical.amount)
          expect(page).to have_content(new_chemical.flammable)
          expect(page).to have_content(new_chemical.created_at)
          expect(page).to have_content(new_chemical.updated_at)
        end
      end
    end
  end

end