require 'aws-sdk'
class AwsWorker::S3Work
  DEFAULT_AVATAR_NAME = "default.svg"
  AVATAR_DIR = "avatar/"
  BUCKET = ENV["BUCKET"]
  
  ####################################################################################

  # デフォルトのプロフィール画像を取得する
  def get_default_avatar
    s3 = Aws::S3::Client.new(
      region: ENV["REGION"],
      access_key_id: ENV["AWS_ACCESS_KEY"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
    default_avatar = s3.get_object(bucket: BUCKET, key: AVATAR_DIR + DEFAULT_AVATAR_NAME).body.read
  end
end