class DoctorsController < ApplicationController
    def index
        @doctors = Doctor.all
    end

    def new
        @doctor = Doctor.new
    end

    def create
        @doctor = Doctor.new(doctor_params)
        if @doctor.save
            redirect_to doctors_path
        else
            render :new
        end
    end

    def update
    end

    def delete
    end

    private

        def doctor_params
            params.require(:doctor).permit(:name, :crm, :crm_uf)
        end
end