require 'pry'

class MusicImporter

    attr_reader :path

    def initialize(path)
        @path = path
    end

    def files
        song_files = Dir.children(path)
    end

    def import 
        files.each do |file|
            Song.create_from_filename(file)
        end
    end

end