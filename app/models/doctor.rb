class Doctor < ApplicationRecord
  validates :name, :crm, :crm_uf, presence: true # All attributes are required.
  validates :crm, uniqueness: true # The system don't agree patients with same CRM
  validates :name, :crm_uf, format: { with: /[a-zA-Z]/ }

  before_destroy do
    cannot_delete_with_appointments
    throw(:abort) if errors.present?
  end

  before_validation do
    update_CRM_with_UF
  end

  private

  # Check if the patient has an appointment
  def cannot_delete_with_appointments
    has_appointment = Appointment.find_by(doctor_id: id)
    errors.add(:base, 'It is not possible to delete a doctor with appointment(s).') unless has_appointment.nil?
  end

  # Add UF to CRM
  def update_CRM_with_UF
    self.crm = crm + crm_uf
  end
end
