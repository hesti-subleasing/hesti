# require 'aws-sdk-s3'

# client = Aws::S3::Client.new(
#   region: 'us-east-2',
#   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
# )
# # Aws.config.update({
# #   region: 'us-east-2',
# #   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
# # })

# S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUCKET'])