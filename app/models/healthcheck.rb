class Healthcheck
  delegate :to_json, to: :to_h

  def app_sha
    read_file "/etc/get-teacher-training-adviser-service-sha"
  end

  def test_api
    GetIntoTeachingApiClient::LookupItemsApi.new.get_teaching_subjects
    true
  rescue Faraday::Error, GetIntoTeachingApiClient::ApiError
    false
  end

  def test_redis
    return nil unless ENV["REDIS_URL"]

    REDIS.ping == "PONG"
  rescue Redis::BaseError
    false
  end

  def to_h
    {
      app_sha:,
      api: test_api,
      redis: test_redis,
    }
  end

private

  def read_file(file)
    File.read(file).strip
  rescue Errno::ENOENT
    nil
  end
end
