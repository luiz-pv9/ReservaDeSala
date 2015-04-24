require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET /signin' do
    it 'returns 200 success' do
      get :new
      expect(response).to be_successful
    end

    it 'renders signin template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST /signin' do
    describe 'valid user' do
      before :each do
        @user = User.create(:username => 'lpvasco', :password => '1234')
      end

      it 'redirects to root' do
        post :create, {:username => 'lpvasco', :password => '1234'}
        expect(response).to redirect_to(root_path)
      end

      it 'assigns flash[:notice]' do
        post :create, {:username => 'lpvasco', :password => '1234'}
        expect(flash[:notice].length).to be > 0
      end

      it 'assigns a session to the user id' do
        post :create, {:username => 'lpvasco', :password => '1234'}
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    describe 'invalid user' do
      it 'renders signin tempate' do
        post :create, {:username => 'lpvasco', :password => '1234'}
        expect(response).to render_template('new')
      end

      it 'assigns flash[:alert]' do
        post :create, {:username => 'lpvasco', :password => '1234'}
        expect(flash[:alert].length).to be > 0
      end
    end
  end

  describe 'GET /signup' do
    it 'returns 200 success' do
      get :signup_new
      expect(response).to be_successful
    end

    it 'renders signin template' do
      get :signup_new
      expect(response).to render_template('signup_new')
    end
  end

  describe 'POST /signup' do
    describe 'valid attributes' do
      it 'creates the user' do
        expect {
          post :signup_create, {:username => 'lpvasco', :password => '1234'}
        }.to change { User.count }.by(1)
      end

      it 'stores the user id in the current session' do
        post :signup_create, {:username => 'lpvasco', :password => '1234'}
        expect(session[:user_id]).to eq(assigns(:user).id)
      end

      it 'redirects to root_path' do
        post :signup_create, {:username => 'lpvasco', :password => '1234'}
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'invalid attributes' do
      it 'renders the signup_new template' do
        post :signup_create, {:username => 'lpvasco', :password => ''}
        expect(response).to render_template('signup_new')
      end

      it 'assigns flash[:alert]' do
        post :signup_create, {:username => 'lpvasco', :password => ''}
        expect(flash[:alert].length).to be > 0
      end
    end
  end

  describe 'GET /logout' do
    def user
      @user ||= User.create(:username => 'lpvasco', :password => '1234')
    end

    it 'sets user_id to nil in the session' do
      get :destroy, {}, {:user_id => user.id}
      expect(session[:user_id]).to be(nil)
    end

    it 'redirect_to the login path' do
      get :destroy, {}, {:user_id => user.id}
      expect(response).to redirect_to('/signin')
    end
  end 
end
