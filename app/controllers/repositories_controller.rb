class RepositoriesController < ApplicationController

  def search
  end

  def github_search
    begin
      @resp = Faraday.get 'https://developer.github.com/v3/search/repositories' do |req|
        req.params['client_id'] = 'GH_BASIC_CLIENT_ID'
        req.params['client_secret'] = 'GH_BASIC_SECRET_ID'
        req.params['q'] = params[:query]
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @repositories = body["items"]
      else
        @error = body["message"]
      end
 
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
