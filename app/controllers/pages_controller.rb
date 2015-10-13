class PagesController < ApplicationController
  # Setup params for the request
  include SetupRequestParams
  include CacheRequest
  include GetApiUri

  def home
    # Unless request cached fetch async members
    FetchMembersJob.perform_later(cache_key, request_uri
    ) unless key_cached?

    # Respond with HTML
    respond_to do |format|
      format.html
    end
  end

end