require 'net/http'
require 'uri'

class PublicsController < ApplicationController
  SHORT_LINK_PREFIX = "#{request.protocol}#{request.raw_host_with_port}"
  layout false

  # GET short_name.example.com
  def show
    @url = Url.find_by(short_url: request.subdomain)

    if @url
      uri = URI.parse(@url.original_url)
      response = Net::HTTP.get_response(uri)

      if ['DENY', 'SAMEORIGIN'].include?(response['X-Frame-Options'])
        redirect_to @url.original_url, allow_other_host: true, status: 302
      else
        render template: 'publics/show'
      end
    else
      render plain: 'Not found 🌚🌚', status: :not_found
    end
  end
end
