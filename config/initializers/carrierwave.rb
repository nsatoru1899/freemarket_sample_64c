require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? # 開発とテスト条件ではファイル保存 3/7
    config.storage = :file
  elsif Rails.env.production? # 本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: 'ap-northeast-1'
    }

    config.fog_directory = 'freemarket-sample-64c'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/freemarket-sample-64c'
  end
end
