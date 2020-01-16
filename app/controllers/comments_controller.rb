class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def create 
        @post = Post.find(params[:post_id])
        @new_comment = Comment.new comment_params
        @new_comment.user = current_user
        @new_comment.post = @post
        if @new_comment.save
            redirect_to post_path(@post)
        else
            @comments = @post.comments.order(created_at: :desc)
            render 'post/show'
        end
    end

    def destroy 
        @comment = Comment.find(params[:id])
        if can? :crud, @comment
            @comment.destroy 
            redirect_to post_path(@comment.post)
        else
            redirect_to root_path, alert: "Not Authorized. Access Denied"
        end
    end

    private 

    def comment_params 
        params.require(:comment).permit(:body)
    end
end
