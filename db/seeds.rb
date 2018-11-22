# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clean out the DB
def wipe_db
  puts "Wiping requests..."
  Request.destroy_all
  puts "... it's done."
  puts "Wiping slots..."
  Slot.destroy_all
  puts "... it's done."
  puts "Wiping jams..."
  Jam.destroy_all
  puts "... it's done."
  puts "Wiping UserInstruments..."
  UserInstrument.destroy_all
  puts "... it's done."
  puts "Wiping instruments..."
  Instrument.destroy_all
  puts "... it's done."
  puts "Wiping users..."
  User.destroy_all
  puts "... it's done."
end

# iterate over instruments YAML
def db_seed(file)
  path = Rails.root.join('db','seeds',file)
  puts "Seeding file #{path}"
  File.open(path) do |file|
    YAML.load_documents(file) do |doc|
      doc.keys.sort.each do |key|
        puts "Seeding key #{key}"
        attributes = doc[key]
        yield(attributes)
      end
    end
  end
  puts "DONE!"
end

# # iterate over instruments YAML
# def db_seed_instruments
#   puts "Seeding instruments..."
#   path = Rails.root.join('db','seeds','instruments.yml')
#   puts "Seeding file #{path}"
#   File.open(path) do |file|
#     YAML.load_documents(file) do |doc|
#       doc.keys.sort.each do |key|
#         puts "Seeding key #{key}"
#         attributes = doc[key]
#         create_a_seed_instrument(attributes)
#       end
#     end
#   end
#   puts "DONE!"
# end

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
  user = User.new(attributes)
  user.save!
  puts "Created #{user.first_name}."
end

# Assign instruments to users
def assign_instruments
  puts "Assigning instruments..."
  users = User.all

  puts "Assigning lead guitar players."
  users[0..4].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = Instrument.first
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end

  puts "Assigning bassists."
  users[3..6].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = Instrument.second
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end

  puts "Assigning drummers."
  users[7..9].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = Instrument.third
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end

  puts "Assigning vocalists."
  users[2..5].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = Instrument.fourth
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end

  puts "Assigning keys."
  users[8..9].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = Instrument.fifth
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end
end

# Begin Seeding
wipe_db
db_seed('instruments.yml') { |attributes| create_a_seed_instrument(attributes) }
# db_seed_instruments
db_seed_users
assign_instruments