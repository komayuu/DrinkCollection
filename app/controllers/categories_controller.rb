class CategoriesController < ApplicationController
  skip_before_action :require_login, only: %i[beer wine nihonshu shochu cocktail etc]
  
  def show
    @category = params[:category]
  end
end
