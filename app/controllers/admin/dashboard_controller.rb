class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.all.count
    @products_categories = Category.all.count
  end

end
