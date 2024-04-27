# frozen_string_literal: true

class CommentsController < ApplicationController
  # As the comment is not a nested user resource,
  # I will leave it without authentication, but it could also be linked to the user
  # before_action :authenticate_user!

  before_action :set_comment, only: %i[show update destroy]

  rescue_from ActionController::ParameterMissing do |exception|
    @error = {
      message: "The required parameter #{exception.param} is missing.",
      details: exception.message
    }

    render 'shared/error', status: :unprocessable_entity
  end

  def index
    @comments = Comment.where(post_id: params[:post_id])
  end

  def show; end

  def create
    @comment = Comment.new(comment_params)

    return error_response('Comment failed to be created.', @comment.errors.full_messages) unless @comment.save

    @message = 'Comment has been successfully created.'
  end

  def update
    unless @comment.update(comment_update_params)
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

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:name, :text).merge(post_id: params[:post_id])
  end

  def comment_update_params
    params.require(:comment).permit(:name, :text)
  end

  def error_response(message, details)
    @error = { message:, details: }
    render 'shared/error', status: :unprocessable_entity
  end
end
