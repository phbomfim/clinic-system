require 'rails_helper'

feature 'creating appointment' do
  before do
    Patient.create(name: 'User Old', birth_date: '08/06/2021', cpf: '859.958.465-07')
    Doctor.create(name: 'User Old', crm: '1234X', crm_uf: 'AM')
  end

  scenario 'sucess' do
    visit new_appointment_path
    fill_in 'appointment[starts_at]', with: Date.tomorrow.to_s + ' 13:30:00 -0300'
    click_button 'Create Appointment'
    expect(page).to have_content "Appointment has been created"
  end

  scenario 'old date/time' do
    visit new_appointment_path
    fill_in 'appointment[starts_at]', with: Time.now
    click_button 'Create Appointment'
    expect(page).to have_content "This date/time has passed."
  end

  scenario 'out of business time' do
    visit new_appointment_path
    fill_in 'appointment[starts_at]', with: Date.tomorrow.to_s + ' 12:30:00 -0300'
    click_button 'Create Appointment'
    expect(page).to have_content "The clinic does not work at this time."
  end

  scenario 'this time is already taken' do
    Appointment.create(starts_at: Date.tomorrow.to_s + ' 13:30:00 -0300', doctor_id: 1, patient_id: 1)
    visit new_appointment_path
    fill_in 'appointment[starts_at]', with: Date.tomorrow.to_s + ' 13:40:00 -0300'
    click_button 'Create Appointment'
    expect(page).to have_content "Exists another appointment at this interval."
  end
end
