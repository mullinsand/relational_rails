require 'rails_helper'

RSpec.describe 'Storage_unit edit' do
  describe 'form for creating edit storage unit record' do
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
        # fill_in('size', with: 4.5)
        choose('fireproof', with: false)

        click_button('Edit storage unit')
        

        expect(current_path).to eq("/storage_units/#{storage_unit.id}")
        expect(page).to have_content('lab4')
        expect(page).to have_content(5.0)
        expect(page).to have_content(false)
      end
    end
  end

end