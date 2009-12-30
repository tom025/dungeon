class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(referance, name, description, connections)
    @rooms << Room.new(referance, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(referance)
    @rooms.detect { |room| room.referance == referance }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  class Player
    attr_accessor :name, :location

    def initialize(player_name)
      @name = player_name
    end
  end

  class Room
    attr_accessor :referance, :name, :description, :connections

    def initialize(referance, name, description, connections)
      @referance = referance
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end
end

#create the main Dungeon object
my_dungeon = Dungeon.new("Fred Bloggs")

#Add rooms to the dungeon
my_dungeon.add_room(:largecave,
                    "Large Cave",
                    "a large cavournus cave",
                    {:west => :smallcave})

my_dungeon.add_room(:smallcave,
                    "Small Cave",
                    "a small, clausterphobic cave",
                    {:east => :largecave})

#Start game in Large cave
my_dungeon.start(:largecave)