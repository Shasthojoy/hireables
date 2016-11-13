class FetchDeveloperWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'urgent', retry: 5

  def perform(login, access_token)
    api = Github::Api.new(access_token)
    api.fetch_developer(login)

  ensure
    ActiveRecord::Base.clear_active_connections!
    ActiveRecord::Base.connection.close
  end
end
