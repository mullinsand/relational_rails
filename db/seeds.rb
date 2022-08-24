# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lab1 = StorageUnit.create!(name: 'lab1', size: 3.0, fireproof: true)
lab2 = StorageUnit.create!(name: 'lab2', size: 4.0, fireproof: false)
hallway = StorageUnit.create!(name: 'hallway', size: 1.5, fireproof: false)
basement = StorageUnit.create!(name: 'basement', size: 8.0, fireproof: true)


ethanol = lab1.chemicals.create!(name: 'ethanol', amount: 600.00, flammable: true, storage_unit_id: 1)
methanol = lab1.chemicals.create!(name: 'methanol', amount: 500.00, flammable: true, storage_unit_id: 1)
propanol = lab1.chemicals.create!(name: 'propanol', amount: 2000.00, flammable: true, storage_unit_id: 1)
acetone = lab1.chemicals.create!(name: 'acetone', amount: 20000.00, flammable: true, storage_unit_id: 1)
potassium_oxalate = lab2.chemicals.create!(name: 'potassium_oxalate', amount: 45.00, flammable: false, storage_unit_id: 3)
