require 'rails_helper'

RSpec.describe 'schedule workflow' do
  it 'registering a room', :js => true do
    login
    expect(page).to have_css('table')
    expect(page).to have_css('a.reservation-link')
    link = page.all('a.reservation-link')[0]
    link.click
    expect(page).to have_content('Reservado para luiz3')
  end

  it 'unregistering a room', :js => true do
    login
    link = page.all('a.reservation-link')[0]
    link.click
    expect(page).to have_content('Reservado para luiz3')
    link.click
    expect(page).not_to have_content('Reservado para luiz3')
  end

  def login
    visit '/signup'
    fill_in 'username', :with => 'luiz3'
    fill_in 'password', :with => '1234'
    click_button 'Entrar'
    expect(page).to have_selector('.alert-success')
  end
end