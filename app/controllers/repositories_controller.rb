class RepositoriesController < ApplicationController

  def search
  end

  def github_search
    begin
      @resp = Faraday.get 'https://developer.github.com/v3/search/repositories' do |req|
        req.params['client_id'] = "d21bb1579e6320ba"
        req.params['client_secret'] = "36e2c7c7153ed6999223bf89520256f5297115e1"
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
