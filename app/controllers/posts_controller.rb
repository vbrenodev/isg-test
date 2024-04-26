# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  def index
    @posts = current_user.posts.where(deleted_at: nil)
  end

  def show; end

  def create
    @post = current_user.posts.build(permitted_params)

    return error_response('Post failed to be created.', @post.errors.full_messages) unless @post.save

    @message = 'Post has been successfully created.'
  end

  def update
    unless @post.update(permitted_params)
      return error_response('Post failed to be updated.', @post.errors.full_messages)
    end

    @message = 'Post has been successfully updated.'
  end

  def destroy
    unless @post.update(deleted_at: Time.zone.now)
      return error_response('Post failed to be deleted.', @post.errors.full_messages)
    end

    @message = 'Post has been successfully deleted.'
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id], deleted_at: nil)
  end

  def permitted_params
    params.require(:post).permit(:title, :text)
  end

  def error_response(message, details)
    @error = { message:, details: }
    render 'shared/error', status: :unprocessable_entity
  end
end
