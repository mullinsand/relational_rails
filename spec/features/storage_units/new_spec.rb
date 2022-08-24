require 'rails_helper'

RSpec.describe 'Storage_unit new' do
  describe 'form for creating new storage unit record' do
    describe 'as a user' do
      it 'has a form to submit storage unit attributes' do
        visit '/storage_units/new'

        fill_in('name', with: 'lab3')
        fill_in('size', with: 5.0)
        choose('fireproof', with: true)
        click_button('Create Storage')
        
        new_storage_unit_id = StorageUnit.last.id
        expect(current_path).to eq('/storage_units')
        expect(page).to have_content('lab3')
      end
    end
  end

end