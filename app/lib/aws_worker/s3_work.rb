require 'aws-sdk'
class AwsWorker::S3Work
  DEFAULT_AVATAR_NAME = 'default.svg'.freeze
  AVATAR_DIR = 'avatar/'.freeze
  BUCKET = ENV['BUCKET']

  ####################################################################################

  # デフォルトのプロフィール画像を取得する
  def get_default_avatar
    s3 = Aws::S3::Client.new(
      region: ENV['REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
    s3.get_object(bucket: BUCKET, key: AVATAR_DIR + DEFAULT_AVATAR_NAME).body.read
  end
end
