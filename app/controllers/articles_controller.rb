class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles
  def index
    @articles = Article.all.page params[:page]
  end

  # GET /articles/1
  def show
     @articles = current_user.articles.page params[:page]
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
    @article = Article.new(article_params)
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
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
