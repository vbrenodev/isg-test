# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  let(:user) { create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'when sign up is successful' do
      it 'returns a success response' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: 'password',
                               password_confirmation: 'password' } },
             format: :json

        expect(response).to have_http_status(:ok)
      end

      it 'renders the create template' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: 'password',
                               password_confirmation: 'password' } },
             format: :json

        expect(response).to render_template('users/registrations/create')
      end

      it 'sets the success message' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: 'password',
                               password_confirmation: 'password' } },
             format: :json

        expect(assigns(:message)).to eq('Signed up and logged successfully.')
      end
    end

    context 'when sign up fails' do
      it 'returns an error response' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: '', password_confirmation: '' } },
             format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error template' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: '', password_confirmation: '' } },
             format: :json
        expect(response).to render_template('shared/error')
      end

      it 'sets the error message and details' do
        post :create,
             params: { user: { name: 'John Doe', email: 'john@example.com', password: '' } },
             format: :json
        expect(assigns(:error)).to eq({ message: 'Signed up failed.',
                                        details: ['Password is too short (minimum is 6 characters)',
                                                  'Password confirmation is too short (minimum is 6 characters)'] })
      end
    end
  end

  describe 'PUT #update' do
    before { sign_in user }

    context 'when update is successful' do
      it 'returns a success response' do
        put :update, params: { user: { name: Faker::Name.name, current_password: 'password' }, format: :json }
        expect(response).to have_http_status(:ok)
      end

      it 'renders the update template' do
        put :update, params: { user: { name: Faker::Name.name, current_password: 'password' }, format: :json }
        expect(response).to render_template('users/registrations/update')
      end

      it 'sets the success message' do
        put :update, params: { user: { name: Faker::Name.name, current_password: 'password' }, format: :json }
        expect(assigns(:message)).to eq('User has been successfully updated.')
      end
    end

    context 'when current password is missing' do
      it 'returns an error response' do
        put :update, params: { user: { name: Faker::Name.name, current_password: '' }, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the error template' do
        put :update, params: { user: { name: Faker::Name.name, current_password: '' }, format: :json }
        expect(response).to render_template('shared/error')
      end

      it 'sets the error message and details' do
        put :update, params: { user: { name: Faker::Name.name, current_password: '' }, format: :json }
        expect(assigns(:error)).to eq({ message: 'Signed up failed.', details: ['Current password can\'t be blank'] })
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user }

    context 'when user is deleted' do
      it 'returns a success response' do
        delete :destroy, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'renders the destroy template' do
        delete :destroy, format: :json
        expect(response).to render_template('users/registrations/destroy')
      end

      it 'sets the success message' do
        delete :destroy, format: :json
        expect(assigns(:message)).to eq('User has been successfully deleted.')
      end
    end
  end
end
