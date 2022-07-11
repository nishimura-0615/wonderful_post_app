class MypagesController < ApplicationController
  def show
    articles = current_user.articles.includes(:tags)
    articles = articles.where(["title LIKE ?","%#{params[:title]}%"]) ,if "%#{params[:title]}%".present?
    @articles = articles.page params[:page]
  end
 end
end
