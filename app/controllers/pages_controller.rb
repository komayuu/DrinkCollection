class PagesController < ApplicationController
  skip_before_action :require_login
  def privacy_policy
  end

  def terms_of_service
  end
end
