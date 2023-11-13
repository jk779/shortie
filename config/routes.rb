# frozen_string_literal: true

require 'subdomain'

Rails.application.routes.draw do
  constraints(Subdomain) do
    get '/', to: 'publics#show'
  end

  # get '/', to: '', constraints: { subdomain: /.+/ }
  resources :urls
end
