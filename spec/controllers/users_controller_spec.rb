require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new links page' do
      get :new, link: {}

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of user and body' do
        post :create, params: { link: { title: 'this is an invalid link'}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
  end
end
