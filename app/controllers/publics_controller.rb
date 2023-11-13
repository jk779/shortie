# frozen_string_literal: true

class PublicsController < ApplicationController
  layout false

  # GET short_name.example.com
  def show
    @url = Url.find_by(short_url: request.subdomain)

    render text: 'Not found 🌚🌚', status: :not_found unless @url
  end
end
