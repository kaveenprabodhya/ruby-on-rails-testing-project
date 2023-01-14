class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destory]
  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # ActionController::Parameters.permit_all_parameters = true
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id])
    if @article.save
      flash[:success] = 'Article was successfully created.'
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated.'
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:success] = 'Article was successfully deleted.'
    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  def show
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:warning] = "You can only edit or delete your artcles"
      redirect_to root_path
    end
  end
end
