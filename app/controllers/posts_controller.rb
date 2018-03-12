class PostsController < ApplicationController

	before_action :set_user
	before_action :set_user_post, only: [:show, :update, :destroy]

	# GET /users/:user_id/posts
  def index
    json_response(@user.posts)
  end

  def show
  	json_response(@post)
  end

  def create
  	@user.posts.create!(post_params)
  	json_response(@post, :created)
  end

  def update
  	@post.update(post_params)
  	head(:no_content)
  end

  def destroy
  	@post.destroy
  	head(:no_content)
  end


  private

  def set_user
  	@user = User.find(params[:user_id])
  end

  def post_params
  	params.permit(:content)
  end

  def set_user_post
  	@post = @user.posts.find_by!(id: params[:id]) if @user
  end



end
