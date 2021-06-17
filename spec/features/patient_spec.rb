require 'rails_helper'

feature 'creating patient' do
    scenario 'sucess' do
        visit new_patient_path
        fill_in 'patient[name]', with: 'User Test'
        fill_in 'patient[birth_date]', with: '08/06/2021'
        fill_in 'patient[cpf]', with: '859.958.465-07'
        click_button 'Create Patient'
        expect(page).to have_content "Patient has been created"
    end

    scenario 'invalid cpf' do
        visit new_patient_path
        fill_in 'patient[name]', with: 'User Test'
        fill_in 'patient[birth_date]', with: '08/06/2021'
        fill_in 'patient[cpf]', with: '1'
        click_button 'Create Patient'
        expect(page).to have_content "Cpf is not a valid CPF"
    end

    scenario 'invalid birthday' do
        visit new_patient_path
        fill_in 'patient[name]', with: 'User Test'
        fill_in 'patient[birth_date]', with: Date.tomorrow
        fill_in 'patient[cpf]', with: '859.958.465-07'
        click_button 'Create Patient'
        expect(page).to have_content "Invalid birthday."
    end

    scenario 'invalid name' do
        visit new_patient_path
        fill_in 'patient[name]', with: 1231234
        fill_in 'patient[birth_date]', with: '08/06/2021'
        fill_in 'patient[cpf]', with: '859.958.465-07'
        click_button 'Create Patient'
        expect(page).to have_content "Name is invalid"
    end
end

context 'editing patient' do

    before do
       Patient.create( name: 'User Old', birth_date: '08/06/2021', cpf: '859.958.465-07')
    end

    scenario 'sucess' do
        visit 'patients/1/edit'
        fill_in 'patient[name]', with: 'User Test'
        click_button 'Update Patient'
        expect(page).to have_content "User Test "
    end

    scenario 'invalid birth_date' do
        visit 'patients/1/edit'
        fill_in 'patient[birth_date]', with: Date.tomorrow
        click_button 'Update Patient'
        expect(page).to have_content "Invalid birthday."
    end

    scenario 'invalid cpf' do
        visit 'patients/1/edit'
        fill_in 'patient[cpf]', with: '1'
        click_button 'Update Patient'
        expect(page).to have_content "Cpf is not a valid CPF"
    end

    scenario 'cpf already exists' do
        Patient.create( name: 'User Two', birth_date: '08/06/2021', cpf: '29027068127')
        visit 'patients/2/edit'
        fill_in 'patient[cpf]', with: '859.958.465-07'
        click_button 'Update Patient'
        expect(page).to have_content "Cpf has already been taken"
    end
end