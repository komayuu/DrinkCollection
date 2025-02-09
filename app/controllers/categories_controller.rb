class CategoriesController < ApplicationController
  skip_before_action :require_login, only: %i[beer wine nihonshu shochu cocktail etc]
  
  def show
    @drinks = Drink.where(drink_type: params[:id])
    render "categories/#{params[:id]}"
  end
end
