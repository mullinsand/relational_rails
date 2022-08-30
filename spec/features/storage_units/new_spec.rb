require 'rails_helper'

RSpec.describe 'Storage_unit new' do
  describe 'as a user' do
    describe 'US11: when I visit storage unit index page, there is a link and then form to create a new storage_unit' do
      it 'has link to create new storage unit record' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
    
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
    
        visit "/storage_units"
    
        expect(page).to have_link("Add new storage unit")
        click_link("Add new storage unit")
        expect(current_path).to eq("/storage_units/new")
      end

      it 'has a form to submit storage unit attributes' do
        visit '/storage_units/new'

        fill_in('name', with: 'lab3')
        fill_in('size', with: 5.0)
        choose('fireproof', with: true)
        click_button('Create Storage')

        new_storage_unit = StorageUnit.last
        expect(current_path).to eq('/storage_units')

        within "#storage_unit_#{new_storage_unit.id}" do
          expect(page).to have_content(new_storage_unit.name)
          expect(page).to have_content(new_storage_unit.fireproof)
          expect(page).to have_content(new_storage_unit.amount)
          expect(page).to have_content(new_storage_unit.updated_at)
          expect(page).to have_content(new_storage_unit.created_at)
        end
      end
    end
  end

end