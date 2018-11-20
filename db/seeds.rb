# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clean out the DB
def wipe_db
  puts "Wiping instruments..."
  Instrument.destroy_all
  puts "DONE!"
  puts "Wiping users..."
  User.destroy_all
  puts "DONE!"
end

# iterate over instruments YAML
def db_seed_instruments
  puts "Seeding instruments..."
  path = Rails.root.join('db','seeds','instruments.yml')
  puts "Seeding file #{path}"
  File.open(path) do |file|
    YAML.load_documents(file) do |doc|
      doc.keys.sort.each do |key|
        puts "Seeding key #{key}"
        attributes = doc[key]
        create_a_seed_instrument(attributes)
      end
    end
  end
  puts "DONE!"
end

# Seed one instrument
def create_a_seed_instrument(attributes)
  Instrument.create(attributes)
  puts "Created #{Instrument.last.name}."
end

# iterate over users YAML
def db_seed_users
  puts "Seeding users..."
  path = Rails.root.join('db','seeds','users.yml')
  puts "Seeding file #{path}"
  File.open(path) do |file|
    YAML.load_documents(file) do |doc|
      doc.keys.sort.each do |key|
        puts "Seeding key #{key}"
        attributes = doc[key]
        create_a_seed_user(attributes)
      end
    end
  end
  puts "DONE!"
end

# Seed one user
def create_a_seed_user(attributes)
  User.create!(attributes)
  puts "Created #{User.last.first_name}."
end

# Begin Seeding
wipe_db
db_seed_instruments
db_seed_users