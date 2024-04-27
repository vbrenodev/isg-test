# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      get :show, format: :json
      expect(response).to render_template('sessions/show')
    end
  end
end
