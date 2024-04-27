# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'with authentication' do
      before { sign_in user }

      it 'returns a success response' do
        get :index, format: :json

        expect(response).to be_successful
      end
    end

    it 'returns an unauthorized response' do
      get :index, format: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post, user:) }

    context 'with authentication' do
      before { sign_in user }

      it 'returns a success response' do
        get :show, params: { id: post.id }, format: :json

        expect(response).to be_successful
      end
    end

    it 'returns an unauthorized response' do
      get :show, params: { id: post.id }, format: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST #create' do
    let(:post_params) { attributes_for(:post) }

    context 'with authentication' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'creates a new post' do
          post :create, params: { post: post_params }, format: :json
          expect(response).to have_http_status(:ok)
        end

        it 'returns a success response' do
          post :create, params: { post: post_params }, format: :json

          expect(response).to be_successful
        end
      end

      context 'with invalid parameters' do
        it 'returns an error response' do
          post :create, params: {}, format: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    it 'returns an unauthorized response' do
      post :create, params: { post: post_params }, format: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH #update' do
    let(:post) { create(:post) }
    let(:post_update_params) { attributes_for(:post) }

    context 'with authentication' do
      before { sign_in user }

      context 'with valid parameters' do
        it 'updates the requested post' do
          patch :update, params: { id: post.id, post: post_update_params }, format: :json

          post.reload
          expect(post.attributes.symbolize_keys).to include(post_update_params)
        end

        it 'returns a success response' do
          patch :update, params: { id: post.id, post: post_update_params }, format: :json

          expect(response).to be_successful
        end
      end

      context 'with invalid parameters' do
        it 'returns an error response' do
          patch :update, params: { id: post.id }, format: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    it 'returns an unauthorized response' do
      patch :update, params: { id: post.id, post: post_update_params }, format: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE #destroy' do
    let(:post) { create(:post) }

    context 'with authentication' do
      before { sign_in user }

      it 'destroys the requested post' do
        delete :destroy, params: { id: post.id }, format: :json

        post.reload
        expect(post.deleted?).to be true
      end

      it 'returns a success response' do
        delete :destroy, params: { id: post.id }, format: :json

        expect(response).to be_successful
      end
    end

    it 'returns an unauthorized response' do
      patch :destroy, params: { id: post.id }, format: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
