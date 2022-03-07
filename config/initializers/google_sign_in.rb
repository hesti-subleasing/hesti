# config/initializers/google_sign_in.rb
Rails.application.configure do
    config.google_sign_in.client_id     = ENV['CLIENT_ID']
    config.google_sign_in.client_secret = ENV['CLIENT_SECRET']
end