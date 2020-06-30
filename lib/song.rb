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
        new_artist = Artist.find_or_create_by_name(artist)
        new_genre = Genre.find_or_create_by_name(genre)
        new_song = Song.new(song, new_artist, new_genre)
        new_song
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

end