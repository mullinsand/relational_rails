require 'rails_helper'

RSpec.describe 'Chemical class' do
  describe '#flammable_chemicals' do
    it 'selects only the chemicals that are flammable' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)

      ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
      methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
      propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
      acetone = lab2.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: 1)
      potassium_oxalate = lab1.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false, storage_unit_id: 3)

      chemicals = Chemical.all

      expect(Chemical.flammable_chemicals).to eq([ethanol, methanol, propanol, acetone])
    end
  end
end