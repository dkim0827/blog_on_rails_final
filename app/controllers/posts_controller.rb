class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_post, only: [:edit,:update,:show, :destroy]
    before_action :authorize!, only: [:edit, :update,]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.user = current_user
        if @post.save
            flash[:notice] = 'Post Created Successfully'
            redirect_to post_path(@post.id)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @post.update post_params
            flash[:notice] = 'Post updated Successfully'
            redirect_to post_path(@post.id)
        else
            render :edit
        end
    end

    def index 
        @posts= Post.order(created_at: :desc)
    end

    def show
        @new_comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
        @post.update_columns(view_count: @post.view_count + 1)
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private
    def find_post
        @post=Post.find_by id:params[:id]
        if @post == nil
            redirect_to root_path, notice: "Post Does Not Exist"
        end
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize! 
        unless can?(:crud, @post)
            redirect_to root_path, notice: 'Not Authorized. Access Denied' 
        end
    end
end