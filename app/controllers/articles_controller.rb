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
  
  def report
   @articles = Article.all
   respond_to do |format|
     format.xlsx  { response.headers['Content-Disposition'] = 'attachment; filename=report.xlsx'}
   end
  end
  
  def report_with_comments
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments
    respond_to do |format|
      format.xlsx { response.headers['Content-Disposition']= 'attachment; filename=report_with_comments.xlsx'}
    end
  end
  
  def import
    Article.import(params[:file])
    redirect_to root_url, notice: "Articles imported"
  end

  private
  
  def params_article
    params.require(:article).permit(:title, :content, :status, :avatar)    
  end
end
