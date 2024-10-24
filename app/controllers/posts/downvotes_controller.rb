class Posts::DownvotesController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is logged in

  def create
    @post = Post.find(params[:post_id])
    @post.downvote_by current_user

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{params[:post_id]}_container", partial: "posts/likes", locals: { post: @post }) }
    end
  end
end
