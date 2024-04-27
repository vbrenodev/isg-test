# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController do
  let(:user) { create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    it 'returns a success response' do
      post :create, params: { user: { email: user.email, password: 'password' } }, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'renders the create template' do
      post :create, params: { user: { email: user.email, password: 'password' } }, format: :json
      expect(response).to render_template('users/sessions/create')
    end

    it 'sets the success message' do
      post :create, params: { user: { email: user.email, password: 'password' } }, format: :json
      expect(assigns(:message)).to eq('You are logged in.')
    end

    it 'return an logged user' do
      post :create, params: { user: { email: user.email, password: 'password' } }, format: :json
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged out successfully' do
      before { sign_in user }

      it 'returns a success response' do
        delete :destroy, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'renders the destroy template' do
        delete :destroy, format: :json
        expect(response).to render_template('users/sessions/destroy')
      end

      it 'sets the success message' do
        delete :destroy, format: :json
        expect(assigns(:message)).to eq('You are logged out')
      end
    end

    context 'when user fails to log out' do
      it 'returns an unauthorized response' do
        delete :destroy, format: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders the error template' do
        delete :destroy, format: :json
        expect(response).to render_template('shared/error')
      end

      it 'sets the failure message' do
        delete :destroy, format: :json
        expect(assigns(:error)).to eq(message: 'Hmm nothing happened.', details: 'User failed to log out.')
      end
    end
  end
end
