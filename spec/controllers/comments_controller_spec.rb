# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController do
  let(:post_params) { create(:post) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { post_id: post_params.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:comment) { create(:comment, post: post_params) }

    it 'returns a success response' do
      get :show, params: { post_id: post_params.id, id: comment.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:comment_params) { attributes_for(:comment) }

    context 'with valid params' do
      it 'creates a new comment' do
        post :create, params: { post_id: post_params.id, comment: comment_params }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success response' do
        post :create, params: { post_id: post_params.id, comment: comment_params }, format: :json
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        post :create, params: { post_id: post_params.id }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, post: post_params) }
    let(:comment_update_params) { attributes_for(:comment) }

    context 'with valid params' do
      it 'updates the requested comment' do
        patch :update, params: { post_id: post_params.id, id: comment.id, comment: comment_update_params },
                       format: :json

        comment.reload
        expect(comment.attributes.symbolize_keys).to include(comment_update_params)
      end

      it 'returns a success response' do
        patch :update, params: { post_id: post_params.id, id: comment.id, comment: comment_update_params },
                       format: :json

        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        patch :update, params: { post_id: post_params.id, id: comment.id, comment: { name: '' } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) { create(:comment, post: post_params) }

    it 'soft deletes the requested comment' do
      delete :destroy, params: { post_id: post_params.id, id: comment.id }, format: :json

      comment.reload
      expect(comment.deleted?).to be true
    end

    it 'returns a success response' do
      delete :destroy, params: { post_id: post_params.id, id: comment.id }, format: :json

      expect(response).to be_successful
    end
  end
end
