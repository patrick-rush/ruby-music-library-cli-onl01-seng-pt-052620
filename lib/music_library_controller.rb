class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome"
    end

# waiting for filename method to work

    def list_songs
        Song.all.sort.each { |song| puts song }
    end

end