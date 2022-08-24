require 'rails_helper'

RSpec.describe 'chemical new' do
  describe 'form for creating new chemical record' do
    describe 'as a user' do
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
        
        new_chemical_id = Chemical.last.id
        expect(current_path).to eq("/storage_units/#{lab1.id}/chemicals")
        expect(page).to have_content('isopropanol')
      end
    end
  end

end