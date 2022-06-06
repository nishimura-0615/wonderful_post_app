class MypagesController < ApplicationController
  def show
    @articles = current_user.articles
  end
end
