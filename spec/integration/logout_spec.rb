require 'rails_helper'

RSpec.describe 'signup workflow', :type => :request do
  it 'redirects back to login page' do
    visit '/signup'
    fill_in 'username', :with => 'luiz2'
    fill_in 'password', :with => '1234'
    click_button 'Entrar'
    expect(page).to have_content('luiz2')
    click_link 'Sair'
    expect(page.current_path).to eq('/signin')
  end
end