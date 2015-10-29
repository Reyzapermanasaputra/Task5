class ArticlesController < ApplicationController
before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.status_active.order("id desc").page(params[:page]).per(5)
  end

  def new
    @article = Article.new
  end

  def edit
    show
  end
  
  def show
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
  end
  
  def create
    @article = Article.new(params_article)
    if @article.save
      flash[:notice] = "successfully"
      redirect_to action: 'index'
    else
      flash[:error] = "The data not valid"
      render 'new'
    end
  end

  def update
    @article = Article.find_by_id(params[:id])
    if @article.update(params_article)
      flash[:notice] = "your data is update"
      redirect_to action: 'index'
    else
      render 'edit'
    end    
  end
  
  def destroy
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect_to action: 'index'
  end
  
  private
  
  def params_article
    params.require(:article).permit(:title, :content, :status, :avatar)    
  end
end
