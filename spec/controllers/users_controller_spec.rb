require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new links page' do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of user and body' do
        post :create, params: { user: { usename: 'grey', password: ''}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    context 'with valid params' do
      it 'redirects the user to users index on success' do
        post :create, params: { user: { usename: 'greys', password: 'password'}}
        expect(response).to redirect_to(users_url)
      end

      it 'logs in the user' do
        post :create, params: { user: { usename: 'greys', password: 'password'}}
        user = User.find_by_credentials('greys', 'password')
        expect(session[:session_token]).to eq(user.session_token)
      end
  end

  subject (:joe) { User.create!(username: 'joe', password: 'password') }

  let (:sally) { User.create!(username: 'sally', password: 'password') }
   
  describe 'POST'
end
