require 'rails_helper'

RSpec.describe ScheduleController, type: :controller do
  describe 'GET /' do
    def user
      @user ||= User.create(:username => 'lpvasco', :password => '1234')
    end

    describe 'when authenticated' do
      it 'returns 200 successful' do
        get :index, {}, {:user_id => user.id}
        expect(response).to be_successful
      end

      it 'renders index template' do
        get :index, {}, {:user_id => user.id}
        expect(response).to render_template('index')
      end

      it 'assigns a list of reservations' do
        get :index, {}, {:user_id => user.id}
        expect(assigns(:reservations).size).to be 0
      end
    end

    describe 'when not authenticated' do
      it 'redirects to signin' do
        get :index
        expect(response).to redirect_to ('/signin')
      end
    end
  end

  describe 'register' do
    def user
      @user ||= User.create(:username => 'lpvasco', :password => '1234')
    end

    describe 'when authenticated' do
      it 'creates an instance of reservation' do
        expect {
          get :register, {:time_start => 2, :day_index => 4, :format => :json}, {:user_id => user.id}
        }.to change { Reservation.count }.by(1)
      end
    end

    describe 'when not authenticated' do
      # TODO
    end
  end

  describe 'unregister' do
    def user
      @user ||= User.create(:username => 'lpvasco', :password => '1234')
    end

    it 'removes the reservation instance' do
      Reservation.create(:user => user, :week => Week.for_date(Time.now),
        :day_index => 3, :time_start => 4, :time_end => 5)

      expect {
        get :unregister, {:day_index => 3, :time_start => 4, :format => :json}, {:user_id => user.id}
      }.to change { Reservation.count }.by(-1)
    end

    it 'ignores if the user unregistering is not the one who registered' do
      # TODO
    end
  end
end
