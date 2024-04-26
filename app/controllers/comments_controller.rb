# frozen_string_literal: true

class CommentsController < ApplicationController
  # As the comment is not a nested user resource,
  # I will leave it without authentication, but it could also be linked to the user
  # before_action :authenticate_user!

  before_action :set_post, only: %i[index show create update destroy]
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = @post.comments.where(deleted_at: nil)
  end

  def show; end

  def create
    @comment = @post.comments.build(permitted_params)

    return error_response('Comment failed to be created.', @comment.errors.full_messages) unless @comment.save

    @message = 'Comment has been successfully created.'
  end

  def update
    unless @comment.update(permitted_params)
      return error_response('Comment failed to be updated.', @comment.errors.full_messages)
    end

    @message = 'Comment has been successfully updated.'
  end

  def destroy
    unless @comment.update(deleted_at: Time.zone.now)
      return error_response('Comment failed to be deleted.', @comment.errors.full_messages)
    end

    @message = 'Comment has been successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id], deleted_at: nil)
  end

  def set_comment
    @comment = Comment.find(params[:id], deleted_at: nil)
  end

  def permitted_params
    params.require(:comment).permit(:name, :text)
  end

  def error_response(message, details)
    @error = { message:, details: }
    render 'shared/error', status: :unprocessable_entity
  end
end
