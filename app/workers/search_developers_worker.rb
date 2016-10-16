class SearchDevelopersWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'urgent'

  def perform(params_cache_key)
    params = Rails.cache.read(params_cache_key)
    api = Github::Api.new

    search = api.search(params)
    search.items.each do |item|
      FetchDeveloperWorker.perform_async(
        item.login
      ) unless Rails.cache.exist?(item.login)
    end
  end
end
