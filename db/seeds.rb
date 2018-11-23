
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
  puts "Created #{Instrument.last.name}."
end

# Seed one user
def create_a_seed_user(attributes)
  User.create!(attributes)
  puts "Created #{User.last.first_name}."
end

# Seed one jam
def create_a_jam(attributes, user)
  jam = Jam.new(attributes)
  jam.user = user
  jam.save!
  puts "Created #{Jam.last.title} hosted by #{Jam.last.user.first_name} #{Jam.last.user.last_name}."
end

def assign_instrument(instrument, start, stop)
  puts "Assigning #{instrument.name}"
  @users[start..stop].each do |user|
    @user_instrument = UserInstrument.new
    @user_instrument.user = user
    @user_instrument.instrument = instrument
    @user_instrument.ability = (rand(5) + 1).to_s
    @user_instrument.save
    puts "#{user.first_name} is now on #{@user_instrument.instrument.name}!"
  end
end

# Begin Seeding
wipe_db

db_seed('instruments.yml') { |attributes| create_a_seed_instrument(attributes) }
@instruments = Instrument.all

db_seed('users.yml') { |attributes| create_a_seed_user(attributes) }
@users = User.all
db_seed('jam01.yml') { |attributes| create_a_jam(attributes, User.where(first_name: "Die").first) }
db_seed('jam02.yml') { |attributes| create_a_jam(attributes, User.where(first_name: "Lou").first) }

assign_instrument(@instruments.first, 0, 4)
assign_instrument(@instruments.second, 3, 6)
assign_instrument(@instruments.third, 7, 9)
assign_instrument(@instruments.fourth, 2, 5)
assign_instrument(@instruments.fifth, 8, 9)