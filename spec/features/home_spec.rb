require 'rails_helper'

feature 'visit acess home' do
  scenario 'sucess' do
    visit root_path

    expect(page).to have_link('Patients')
    expect(page).to have_link('Doctors')
    expect(page).to have_link('Appointments')
    expect(page).to have_button('Aplicar')
    expect(page).to have_content "Filter: All doctors"
    expect(current_path).to eq(root_path)
  end
end