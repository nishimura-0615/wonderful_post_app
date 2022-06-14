class MypagesController < ApplicationController
  def show
    @articles = current_user.articles.page params[:page]
  end
end
