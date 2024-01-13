# frozen_string_literal: true

require 'net/http'
require 'uri'

class PublicsController < ApplicationController
  layout false

  TLKMDEV_REGEX = /\A[a-zA-Z0-9]+\.tlkm\.dev\z/

  # GET short_name.example.com
  def show
    @url = if request.host.match?(TLKMDEV_REGEX)
      Url.find_by(short_url: request.subdomain)
    elsif (matching_whole_host = Url.find_by(short_url: request.host))
      matching_whole_host
    else
      return render plain: 'Not found 🌚🌚', status: :not_found
    end

    response = Net::HTTP.get_response(URI.parse(@url.original_url))

    if %w[DENY SAMEORIGIN].include?(response['X-Frame-Options'])
      redirect_to @url.original_url, allow_other_host: true, status: :found
    else
      render template: 'publics/show'
    end
  end
end
