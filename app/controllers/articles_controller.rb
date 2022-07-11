class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!,only: %i[ index show ]
  before_action :set_article, only: %i[ edit update destroy ]

  # GET /articles
  def index
    articles = Article.all.includes(:tags)
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.all.page params[:page]
  end
  # GET /articles/1
  def show
    @article = Article.find(params[:id])
  end


  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "記事が作成されました。"
    else
      render :new,status: :unprocessable_entity
    end
  end


  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "記事が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_url, notice: "記事が削除されました。"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = current_user.articles.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title,:content,tag_ids:[])
  end
end
