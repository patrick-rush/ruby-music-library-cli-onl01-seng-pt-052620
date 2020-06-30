require 'pry'

class Artist
    extend Concerns::Findable


    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def save
        self.class.all << self
        self
    end

    def self.create(name)
        self.new(name).save
    end

    def add_song(song)
        song.artist || song.artist = self
        unless songs.include?(song)
            songs << song
        end
    end

    def genres
        x = songs.collect { |song| song.genre }
        x.uniq
    end

end