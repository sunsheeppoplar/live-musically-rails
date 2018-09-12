Paperclip::DataUriAdapter.register

AWS_ACCESS_KEY_ID = Rails.env.production ? ENV["AWS_ACCESS_KEY_ID"] : Rails.application.secrets.aws_access_key_id
AWS_SECRET_ACCESS_KEY = Rails.env.production ? ENV["AWS_SECRET_ACCESS_KEY"] : Rails.application.secrets.aws_secret_access_key

Paperclip.options[:command_path] = "/usr/local/bin/"
config.paperclip_defaults = {
storage: :s3,
s3_credentials: {
  bucket: "live-musically-dev",
  access_key_id: AWS_ACCESS_KEY_ID,
  secret_access_key: AWS_SECRET_ACCESS_KEY,
  s3_region: "us-east-1"
}
}