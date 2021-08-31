class PostsController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    if params[:back]
    
    @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
      if params[:back]
        render :new
      else
        if @post.save
          flash[:success] = "Post crée avec succès"
          redirect_to posts_url
        else
          render :new
        end
      end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
    
  end

  def update
   
      if @post.update(post_params)
        flash[:success] = "Post mis à jour avec succès"
        redirect_to posts_url
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
    flash[:danger] = "Post supprimé avec succès."
    redirect_to posts_url
      
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:illustration, :illustration_cache, :description, :user_id)
    end
end
