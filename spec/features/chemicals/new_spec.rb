require 'rails_helper'

RSpec.describe 'chemical new' do
  describe 'form for creating new chemical record' do
    describe 'as a user' do
      it 'has a form to submit chemical attributes' do
        visit '/chemicals/new'

        fill_in('name', with: 'isopropanol')
        fill_in('amount', with: 300.00)
        choose('flammable', with: true)
        click_button('Create Chemical')
        
        new_chemical_id = Chemical.last.id
        expect(current_path).to eq('/chemicals')
        expect(page).to have_content('isopropanol')
      end
    end
  end

end