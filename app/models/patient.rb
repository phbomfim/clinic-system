class Patient < ApplicationRecord
  validates :name, :birth_date, :cpf, presence: true # All attributes are required.
  validates :cpf, uniqueness: true # The system don't agree patients with same CPF
  validates :name, format: { with: /[a-zA-Z]/ }

  validates_cpf_format_of :cpf

  before_save do
    formatCPF
    birthDateIsValid
    throw(:abort) if errors.present?
  end

  before_destroy do
    cannot_delete_with_appointments
    throw(:abort) if errors.present?
  end

  private

  # If the user add CPF without symbols (. and -)
  def formatCPF
    numero = CPF.new(cpf)
    self.cpf = numero.formatted
  end

  # Check if the patient has an appointment
  def cannot_delete_with_appointments
    has_appointment = Appointment.find_by(patient_id: id)
    errors.add(:base, 'It is not possible to delete a patient with appointment(s).') unless has_appointment.nil?
  end

  # Check if the birth date is in the past
  def birthDateIsValid
    errors.add(:base, 'Invalid birthday.') if birth_date > Date.today
  end
end
