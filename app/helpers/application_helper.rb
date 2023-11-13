# frozen_string_literal: true

module ApplicationHelper
  def hostname_de_admintrator(request)
    request.host.split('.').without('admin').join('.')
  end
end
