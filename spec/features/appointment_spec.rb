require 'rails_helper'

feature 'creating appointment' do

    before do
        Patient.create( name: 'User Old', birth_date: '08/06/2021', cpf: '859.958.465-07')
        Doctor.create( name: 'User Old', crm: '1234X', crm_uf: 'AM')
    end

    scenario 'sucess' do
        visit new_appointment_path
        fill_in 'appointment[starts_at]', with:  Date.tomorrow.to_s + ' 13:30:00 -0300'
        click_button 'Create Appointment'
        expect(page).to have_content "Appointment has been created"
    end

    scenario 'old datetime' do
        visit new_appointment_path
        fill_in 'appointment[starts_at]', with:  Time.now
        click_button 'Create Appointment'
        expect(page).to have_content "This date/time has passed."
    end
end