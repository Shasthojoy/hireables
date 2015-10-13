module Github

  class Uri

    # Handles API uri selection
    #   params : query_params
    # Returns formatted api url

    def initialize(params)
      @params = params
    end

    def get
      paginated? ? paginated_uri : default_uri
    end

    def paginated_uri
      default_uri + "&page=#{@params[:page]}"
    end

    private

      def default_uri
        "/search/users?q=#{@params[:q]}"
      end

      def paginated?
        @params[:page].present?
      end

  end

end