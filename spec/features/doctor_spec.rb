require 'rails_helper'

context 'creating doctor' do
  scenario 'sucess' do
    visit new_doctor_path
    fill_in 'doctor[name]', with: 'User Test'
    fill_in 'doctor[crm]', with: '1234X'
    fill_in 'doctor[crm_uf]', with: 'AM'
    click_button 'Create Doctor'
    expect(page).to have_content 'Doctor has been created'
  end

  scenario 'invalid crm_uf' do
    visit new_doctor_path
    fill_in 'doctor[name]', with: 'User Test'
    fill_in 'doctor[crm]', with: 12_345
    fill_in 'doctor[crm_uf]', with: 1
    click_button 'Create Doctor'
    expect(page).to have_content 'Crm uf is invalid'
  end

  scenario 'invalid name' do
    visit new_doctor_path
    fill_in 'doctor[name]', with: 1_231_234
    fill_in 'doctor[crm]', with: 12_345
    fill_in 'doctor[crm_uf]', with: 'AM'
    click_button 'Create Doctor'
    expect(page).to have_content 'Name is invalid'
  end
end

context 'editing doctor' do
  before do
    Doctor.create(name: 'User Old', crm: '1234X', crm_uf: 'AM')
  end

  scenario 'sucess' do
    visit 'doctors/1/edit'
    fill_in 'doctor[name]', with: 'User Test'
    click_button 'Update Doctor'
    expect(page).to have_content 'User Test '
  end

  scenario 'invalid crm_uf' do
    visit 'doctors/1/edit'
    fill_in 'doctor[crm_uf]', with: 1
    click_button 'Update Doctor'
    expect(page).to have_content 'Crm uf is invalid'
  end

  scenario 'invalid name' do
    visit 'doctors/1/edit'
    fill_in 'doctor[name]', with: 1_231_234
    click_button 'Update Doctor'
    expect(page).to have_content 'Name is invalid'
  end

  scenario 'crm already exists' do
    Doctor.create(name: 'User Old', crm: '1234X1', crm_uf: 'AM')
    visit 'doctors/2/edit'
    fill_in 'doctor[crm]', with: '1234X'
    click_button 'Update Doctor'
    expect(page).to have_content 'Crm has already been taken'
  end
end

# context 'deleting a doctor' do
#    before do
#        Doctor.create( name: 'User Old', crm: '1234X', crm_uf: 'AM')
#        #Patient.create( name: 'User Old', birth_date: '08/06/2021', cpf: '859.958.465-07')
#        #Appointment(starts_at:  Date.tomorrow.to_s + ' 13:30:00 -0300', doctor_id: 1, patient_id: 1)
#    end

#    scenario 'this doctor has appointments' do
#        visit doctors_path
#        #click_on 'Delete'
#        #click_on 'OK'
#        accept_confirm do
#            click_on 'Delete'
#          end
#        expect(page).to have_content "Doctor has been deleted"
#    end
# end
