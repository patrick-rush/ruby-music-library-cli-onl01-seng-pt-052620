class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist="no artist", genre="no genre")
        @name = name
        unless artist == "no artist"
            self.artist = artist
        end
        unless genre == "no genre"
            self.genre = genre
        end
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


    def artist=(artist)
         @artist = artist
         artist.add_song(self)
    end

# THIS #GENRE= NEEDS TO BE REFACTORED 

    def genre=(genre)
        @genre = genre
        unless genre == "no genre"
            unless genre.songs.include?(self)
                genre.songs << self
            end
        end
    end

    def self.new_from_filename(filename)
        artist, song, genre = filename.chomp(".mp3").split(" - ")
        new_artist = Artist.new(artist)
        new_genre = Genre.new(genre)
        self.find_by_name(song)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

    # "Thundercat - For Love I Come - dance.mp3"
        # def self.new_by_filename(filename)
    #     artist, song, genre = filename.chomp(".mp3").split(" - ")
    #     new_song = self.new(song)
    #     new_song.artist_name = artist
    #     new_song
    # end


# ["Jurassic 5 - What's Golden - hip-hop.mp3",
#  "Real Estate - It's Real - hip-hop.mp3",
#  "Real Estate - Green Aisles - country.mp3",
#  "Thundercat - For Love I Come - dance.mp3",
#  "Action Bronson - Larry Csonka - indie.mp3"]

end    


    # def self.find_by_name(name)
    #     all.find { |song| song.name == name }
    # end

    # def self.find_or_create_by_name(name)
    #     self.find_by_name(name) || self.create(name)
    # end
