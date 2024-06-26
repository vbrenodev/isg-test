# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  rescue_from ActionController::ParameterMissing do |exception|
    @error = {
      message: "The required parameter #{exception.param} is missing.",
      details: exception.message
    }

    render 'shared/error', status: :unprocessable_entity
  end

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def show; end

  def create
    @post = Post.new(post_params)

    return error_response('Post failed to be created.', @post.errors.full_messages) unless @post.save

    @message = 'Post has been successfully created.'
  end

  def update
    unless @post.update(post_update_params)
      return error_response('Post failed to be updated.', @post.errors.full_messages)
    end

    @message = 'Post has been successfully updated.'
  end

  def destroy
    return error_response('Post failed to be deleted.', @post.errors.full_messages) unless @post.destroy

    @message = 'Post has been successfully deleted.'
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text).merge(user_id: current_user.id)
  end

  def post_update_params
    params.require(:post).permit(:title, :text)
  end

  def error_response(message, details)
    @error = { message:, details: }
    render 'shared/error', status: :unprocessable_entity
  end
end
