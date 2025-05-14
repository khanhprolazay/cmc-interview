module Service
    module FileUpload
      class AbstractFileUploadService
        def upload(file)
            raise NotImplementedError
        end

        def delete(file_identifier)
            raise NotImplementedError
        end

        def exists?(file_identifier)
            raise NotImplementedError
        end

        def download(file_identifier)
            raise NotImplementedError
        end
      end
    end
end
