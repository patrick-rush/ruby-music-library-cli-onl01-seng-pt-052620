class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        input = ""
        until input == "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.chomp
            if input == 'list songs'
                self.list_songs
            elsif input == 'list artists'
                self.list_artists
            elsif input == 'list genres'
                self.list_genres
            elsif input == 'list artist'
                self.list_songs_by_artist
            elsif input == 'list genre'
                self.list_songs_by_genre
            elsif input == 'play song'
                self.play_song
            end
        end
    end

    def list_songs
        Song.all.sort! { |a, b| a.name <=> b.name }
        Song.all.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort! {|a, b| a.name <=> b.name }
        Artist.all.each_with_index do |artist, index|
            puts "#{index + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort! { |a, b| a.name <=> b.name }
        Genre.all.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist = Artist.find_by_name(gets.chomp)
        unless artist == nil
            artist.songs.sort! { |a, b| a.name <=> b.name }
            artist.songs.each_with_index do |song, index|
                puts "#{index + 1}. #{song.name} - #{song.genre.name}" 
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = Genre.find_by_name(gets.chomp)
        unless genre == nil
            genre.songs.sort! { |a, b| a.name <=> b.name }
            genre.songs.each_with_index do |song, index|
                puts "#{index + 1}. #{song.artist.name} - #{song.name}" 
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        index = gets.chomp.to_i# - 1
        if index > 0 && index < Song.all.size
            song_choice = Song.all[index]
            puts "Playing #{song_choice.name} by #{song_choice.artist.name}"
        end
    end

end