class Doctor < ApplicationRecord
  validates :name, :crm, :crm_uf, presence: true # All attributes are required.
  validates :crm, uniqueness: true # The system don't agree patients with same CRM
  validates :name, :crm_uf, format: { with: /[a-zA-Z]/ }

  # Falta verificar se existe doctor em alguma consulta com ends_at antes do datetime atual
  before_destroy do
    cannot_delete_with_appointments
    throw(:abort) if errors.present?
  end

  before_validation do
    update_CRM_with_UF
  end

  private

  def cannot_delete_with_appointments
    has_appointment = Appointment.find_by(doctor_id: self.id)
    errors.add(:base, 'It is not possible to delete a doctor with appointment(s).') if !has_appointment.nil?
  end

  def update_CRM_with_UF
    self.crm = self.crm + self.crm_uf
  end
end
