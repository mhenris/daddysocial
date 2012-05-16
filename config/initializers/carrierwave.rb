if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.fog_directory  = 'ds_dev' # When using fog for development
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_directory  = 'ds' # Use bucket 'ds' in production
  end
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAISLUXT3CKMHVPHEQ',       # required
    :aws_secret_access_key  => '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',       # required
    #:region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  #config.fog_public     = false                                   # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
