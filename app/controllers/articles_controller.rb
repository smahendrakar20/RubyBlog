class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
    
    def index
        @articles = Article.all
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    
    end

    def new 
        @article = Article.new
    end
    
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else 
            render 'edit'
        end
    end
    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params) # this is where we use the model Article to create a new 
        # instance in the database
        
        if @article.save #check if the article is valid!!!
            redirect_to @article
        else
            render 'new' # The render method is used so that the @article object is passed back to the new template when it is rendered.
        end
    end

   

    def show
        @article = Article.find(params[:id])
    end

    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end
