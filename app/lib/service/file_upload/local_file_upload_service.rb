module Service
  module FileUpload
    class LocalFileUploadService < AbstractFileUploadService
      STORAGE_DIRECTORY = "./uploads"

      def initialize
        Dir.mkdir(STORAGE_DIRECTORY) unless Dir.exist?(STORAGE_DIRECTORY)
      end

      def upload(file)
        raise "No file provided" unless file

        file_path = File.join(STORAGE_DIRECTORY, file[:filename])

        File.open(file_path, "wb") do |f|
          f.write(file[:tempfile].read)
        end

        file_path
      end

      def delete(file_identifier)
        if File.exist?(file_identifier)
          File.delete(file_identifier)
          true
        else
          false
        end
      end

      def exists?(file_identifier)
        File.exist?(file_identifier)
      end

      def download(file_identifier)
        if File.exist?(file_identifier)
          File.read(file_identifier)
        else
          nil
        end
      end
    end
  end
end
