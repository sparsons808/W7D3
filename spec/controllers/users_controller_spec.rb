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
  end



  subject (:joe) { User.create!(username: 'joe', password: 'password') }

  let (:sally) { User.create!(username: 'sally', password: 'password') }
   
  describe 'Get #show' do
    context 'when logged in' do
      before do 
        allow(controller).to recieve(:current_user) { joe }
      end
      it 'renders the show page of the specified user' do
        get :show, params: { id: joe.id }
        fetched_user = controller.instance_variable_get(:@user)
        expect(fetched_user).to eq(User.find(joe.id))
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      before do 
        allow(controller).to recieve(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :show, params: { id: joe.id }
        expect(response).to redirect_to(new_session_url)
      end

    end
  end

  describe 'Get #index' do
    context 'when logged in' do
      before do 
        allow(controller).to recieve(:current_user) { joe }
      end
      it 'renders the index page of all the user' do
        get :index
        fetched_users = controller.instance_variable_get(:@users)
        expect(fetched_users).to eq(User.all)
        expect(response).to render_template(:index)
      end
    end
    context 'when logged out' do
      before do 
        allow(controller).to recieve(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(new_session_url)
      end

    end
    
  end
end
