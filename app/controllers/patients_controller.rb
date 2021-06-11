class PatientsController < ApplicationController
    def index
        @patients = Patient.all
    end

    def new
        @patient = Patient.new
    end

    def create
        @patient = Patient.new(patient_params)
        if @patient.save
            redirect_to patients_path
        else
            render :new
        end
    end

    def update
    end

    def delete
    end

    private

        def patient_params
            params.require(:patient).permit(:name, :birth_date, :cpf)
        end
end