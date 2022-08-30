require 'rails_helper'

RSpec.describe 'Storage_unit edit' do
  describe 'US12: form for creating edit storage unit record' do
    describe 'as a user' do
      it 'links to the edit page' do
        storage_unit = StorageUnit.create(name: "lab3", size: 5.0, fireproof: false)

        visit '/storage_units'
        click_link 'Edit'
        expect(current_path).to eq("/storage_units/#{storage_unit.id}/edit")
      end

      it 'has a prefilled form to edit storage unit attributes' do
        storage_unit = StorageUnit.create(name: "lab3", size: 5.0, fireproof: false)
        visit "/storage_units/#{storage_unit.id}/edit"

        fill_in('name', with: 'lab4')
        choose('fireproof', with: true)

        click_button('Edit storage unit')
        
        edited_storage_unit = StorageUnit.find(storage_unit.id)

        expect(current_path).to eq("/storage_units/#{storage_unit.id}")
        within "#storage_unit_#{storage_unit.id}" do
          expect(page).to have_content(edited_storage_unit.name)
          expect(page).to have_content(storage_unit.size)
          expect(page).to have_content(edited_storage_unit.fireproof)
          expect(page).to have_content(edited_storage_unit.created_at)
          expect(page).to have_content(edited_storage_unit.updated_at)
        end
      end
    end
  end

end