
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

# Seed one instrument
def create_a_seed_instrument(attributes)
  Instrument.create!(attributes)
  @instruments << Instrument.last
  puts "Created #{Instrument.last.name}."
end

# Seed one user
def create_a_seed_user(attributes)
  User.create!(attributes)
  @users << User.last
  puts "Created #{User.last.first_name}."
end

# Seed one jam
def create_a_jam(attributes, user)
  jam = Jam.new(attributes)
  jam.user = user
  jam.save!
  puts "Created #{Jam.last.title} hosted by #{Jam.last.user.first_name} #{Jam.last.user.last_name}."
end

def assign_instrument(instrument, index_array)
  puts "Assigning #{instrument.name}"
  @users.values_at(*index_array).each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = instrument
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end
end

# Begin Seeding
# Nuke everything
wipe_db

# Seed instruments
@instruments = []
db_seed('instruments.yml') { |attributes| create_a_seed_instrument(attributes) }

# Seed users
@users = []
db_seed('users.yml') { |attributes| create_a_seed_user(attributes) }

# Assign instruments to users
assign_instrument(@instruments[0], [0, 8, 12, 13]) # lead guitar
assign_instrument(@instruments[1], [2, 11]) # bass guitar
assign_instrument(@instruments[2], [3, 4, 7]) # drums
assign_instrument(@instruments[3], [1, 6, 9, 10, 4, 13]) # vocals
assign_instrument(@instruments[4], [5]) # keys

# Seed jams
puts "Seeding jams..."
db_seed('jam01.yml') { |attributes| create_a_jam(attributes, @users[0]) }
puts "Assigning slots to #{Jam.last.title}"
Slot.create!(jam: Jam.last, instrument: @instruments[0], user: @users[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[4])
Slot.create!(jam: Jam.last, instrument: @instruments[3])
sleep 5
puts "DONE!"

db_seed('jam02.yml') { |attributes| create_a_jam(attributes, @users[10]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[7])
Slot.create!(jam: Jam.last, instrument: @instruments[3], user: @users[10])
Slot.create!(jam: Jam.last, instrument: @instruments[4], user: @users[5])
sleep 5
puts "DONE!"

db_seed('jam03.yml') { |attributes| create_a_jam(attributes, @users[13]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1], user: @users[2])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[8])
Slot.create!(jam: Jam.last, instrument: @instruments[4])
sleep 5
puts "DONE!"

db_seed('jam04.yml') { |attributes| create_a_jam(attributes, @users[4]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[0], user: @users[12])
Slot.create!(jam: Jam.last, instrument: @instruments[1], user: @users[2])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[4])
sleep 5
puts "DONE!"

db_seed('jam05.yml') { |attributes| create_a_jam(attributes, @users[1]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1], user: @users[11])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[3])
Slot.create!(jam: Jam.last, instrument: @instruments[3], user: @users[1])
# sleep 5
puts "DONE!"


db_seed('jam06.yml') { |attributes| create_a_jam(attributes, @users[12]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1], user: @users[11])
Slot.create!(jam: Jam.last, instrument: @instruments[2])
Slot.create!(jam: Jam.last, instrument: @instruments[3], user: @users[6])
sleep 5
puts "DONE!"


db_seed('jam07.yml') { |attributes| create_a_jam(attributes, @users[9]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[4])
Slot.create!(jam: Jam.last, instrument: @instruments[3], user: @users[9])
sleep 5
puts "DONE!"


db_seed('jam08.yml') { |attributes| create_a_jam(attributes, @users[7]) }
Slot.create!(jam: Jam.last, instrument: @instruments[0])
Slot.create!(jam: Jam.last, instrument: @instruments[1], user: @users[2])
Slot.create!(jam: Jam.last, instrument: @instruments[2], user: @users[7])
Slot.create!(jam: Jam.last, instrument: @instruments[3], user: @users[10])
sleep 5
puts "ALL DONE!"

puts "Making requests on empty slots..."
Slot.where(user_id: nil).each do |slot|
  Request.create!(slot: slot, user: @users[1..-1].sample, message: "Please can I be on #{slot.instrument.name}?")
end
puts "ALL DONE!"

puts "SEEDING COMPLETE! Stay out of trouble ;)"