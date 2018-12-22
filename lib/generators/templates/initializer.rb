GrapeSimpleAuth.setup do |config|
  # your authentication server
  config.url = ENV["AUTH_BASE_URL"]

  # your endpoint
  config.verify_endpoint = ENV["VERIFY_ENDPOINT"]
end