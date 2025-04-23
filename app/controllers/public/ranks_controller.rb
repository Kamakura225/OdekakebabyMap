class Public::RanksController < ApplicationController
  def top_users
    @top_users = User.all.sort_by(&:total_good_likes).reverse.take(10)
  end
end
