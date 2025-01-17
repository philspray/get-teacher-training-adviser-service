GetIntoTeachingApiClient.configure do |config|
  endpoint = ENV["GIT_API_ENDPOINT"].presence || Rails.application.config.x.git_api_endpoint.presence

  if endpoint
    parsed = URI.parse(endpoint)
    config.host = parsed.hostname
  end

  config.api_key["apiKey"] = ENV["GIT_API_TOKEN"].presence

  config.server_index = nil
  config.api_key_prefix["apiKey"] = "Bearer"
  config.scheme = "https"
  config.cache_store = Rails.application.config.x.api_client_cache_store

  config.circuit_breaker = {
    enabled: true,
    threshold: 5,
    timeout: 5.minutes,
  }
end
