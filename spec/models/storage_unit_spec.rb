# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created

require "rails_helper"

RSpec.describe 'Storage unit model' do
  describe '#sort_by_creation' do
    it 'sorts storage units by creation with newest record first' do
      lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
      sleep(1)
      lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
      expect(StorageUnit.sort_by_creation).to eq([lab2, lab1])
      sleep(1)
      hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
      sleep(1)
      basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)
      expect(StorageUnit.sort_by_creation).to eq([basement, hallway, lab2, lab1])
    end
  end
end