# app/controllers/posts_controller.rb

class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authenticate_request
  
    # GET /posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /posts/:id
    def show
      render json: @post
    end
  
    # POST /posts
    def create
      @post = Post.new(post_params)
      @post.user = current_user
  
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/:id
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:id
    def destroy
      @post.destroy
      head :no_content
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
  