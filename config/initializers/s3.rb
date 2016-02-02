
CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               = ENV["provider"]
      :user_name              = ENV["user_name"]
      :aws_access_key_id      = ENV["access_key_id"]
      :aws_secret_access_key  = ENV["secret_access_key"]
      :region                 => 'us-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "petpal"
end
