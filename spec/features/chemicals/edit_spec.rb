require 'rails_helper'

RSpec.describe 'chemical new' do
  describe 'form for updating new chemical record' do
    describe 'as a user' do
      it 'links to the edit page' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: lab1.id)

        visit "/chemicals/#{ethanol.id}"
        click_link 'Edit'
        expect(current_path).to eq("/chemicals/#{ethanol.id}/edit")
      end

      it 'has a form to submit chemical attributes' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: lab1.id)

        visit "/chemicals/#{ethanol.id}"
        click_link 'Edit'
        #storage is prefilled

        fill_in('name', with: 'isopropanol')
        fill_in('amount', with: 300.00)
        click_button('Edit Chemical')
        
        new_chemical_id = Chemical.last.id
        expect(current_path).to eq("/chemicals/#{ethanol.id}")
        expect(page).to have_content('isopropanol')
        expect(page).to have_content(300.00)
        expect(page).to have_content(lab1.name)
        expect(page).to have_content(ethanol.flammable)
      end
    end
  end

end