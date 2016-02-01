
CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAJDM46HGHY22A4GCQ",
      :aws_secret_access_key  => "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",
      :region                 => 'us-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "petpal"
end
