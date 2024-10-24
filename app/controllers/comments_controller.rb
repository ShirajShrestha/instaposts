class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  def index
    @comments = Comment.all
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      # redirect_to post_path(@post), notice: "Comment created successfully."
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("comments_for_post_#{@post.id}", partial: "comments/comment", locals: { comment: @comment })
        end
        format.html { redirect_to post_path(@post), notice: "Comment created successfully." }
      end
    else
      flash[:alert] = "Invalid params"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    # redirect_to @post, notice: "Comment was successfully deleted."
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@comment))
      end
      format.html { redirect_to post_path(@post), notice: "Comment was successfully deleted." }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :id)
  end
end
