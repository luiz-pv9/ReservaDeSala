require 'rails_helper'

RSpec.describe 'signup workflow', :type => :request do
  it 'redirects to root path if success' do
    visit '/signup'
    fill_in 'username', :with => 'luiz2'
    fill_in 'password', :with => '1234'
    click_button 'Entrar'

    expect(page).to have_selector(".alert-success", :count => 1)
  end

  it 'renders an warning with invalid attributes' do
    visit '/signup'
    fill_in 'username', :with => ''
    fill_in 'password', :with => '1234'
    click_button 'Entrar'

    expect(page).to have_selector(".alert-warning", :count => 1)
  end
end