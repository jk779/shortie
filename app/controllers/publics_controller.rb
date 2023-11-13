# frozen_string_literal: true

require 'net/http'
require 'uri'

class PublicsController < ApplicationController
  layout false

  # GET short_name.example.com
  def show
    @url = Url.find_by(short_url: request.subdomain)
    return render plain: 'Not found 🌚🌚', status: :not_found unless @url

    response = Net::HTTP.get_response(URI.parse(@url.original_url))

    if %w[DENY SAMEORIGIN].include?(response['X-Frame-Options'])
      redirect_to @url.original_url, allow_other_host: true, status: :found
    else
      render template: 'publics/show'
    end
  end
end
