
Rails.application.config.to_prepare do
  Container.register(:file_upload, Service::FileUpload::LocalFileUploadService.new)
  Container.register(:iam, Service::Iam::KeycloakOfflineValidationService.new)
end
