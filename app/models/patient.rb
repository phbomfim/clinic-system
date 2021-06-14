class Patient < ApplicationRecord

    validates :name, :birth_date, :cpf, presence: true # All attributes are required.
    validates :cpf, uniqueness: true # The system don't agree patients with same CPF

    validates_cpf_format_of :cpf

    before_save do 
        formatCPF
    end

    private

        def formatCPF
            numero = CPF.new(self.cpf)
            self.cpf = numero.formatted
        end
end
