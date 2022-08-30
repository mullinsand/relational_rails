require 'rails_helper'

RSpec.describe 'chemical new' do
  describe 'US14: form for updating new chemical record' do
    describe 'as a user' do
      it 'links to the edit page for chemicals' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)

        visit "/chemicals/#{ethanol.id}"
        click_link 'Edit'
        expect(current_path).to eq("/chemicals/#{ethanol.id}/edit")
      end

      it 'has a form to submit chemical attributes' do
        lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
        ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true)

        visit "/chemicals/#{ethanol.id}"
        click_link 'Edit'
        #storage is prefilled

        fill_in('name', with: 'isopropanol')
        fill_in('amount', with: 300.00)
        click_button('Edit Chemical')

        edited_chemical = Chemical.last
        expect(current_path).to eq("/chemicals/#{edited_chemical.id}")
        within "#chemical_#{edited_chemical.id}" do
          expect(page).to have_content(edited_chemical.name)
          expect(page).to have_content(edited_chemical.amount)
          expect(page).to have_content(ethanol.flammable)
          expect(page).to have_content(edited_chemical.created_at)
          expect(page).to have_content(edited_chemical.updated_at)
        end
      end
    end
  end

end