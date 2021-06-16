class Patient < ApplicationRecord

    validates :name, :birth_date, :cpf, presence: true # All attributes are required.
    validates :cpf, uniqueness: true # The system don't agree patients with same CPF

    validates_cpf_format_of :cpf

    before_save do 
        formatCPF
    end

    before_destroy do 
        cannot_delete_with_appointments
        throw(:abort) if errors.present?
    end

    private

        def formatCPF
            numero = CPF.new(self.cpf)
            self.cpf = numero.formatted
        end

        def cannot_delete_with_appointments
            has_appointment = Appointment.find_by(patient_id: self.id)
            errors.add(:base, 'It is not possible to delete a patient with appointment(s).') if !has_appointment.nil?
        end
end
