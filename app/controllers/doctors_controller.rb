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
            redirect_to doctors_path, notice: "Your doctor has been created"
        else
            render :new
        end
    end

    def edit
        @doctor = Doctor.find(params[:id])
    end

    def update
        @doctor = Doctor.find(params[:id])
        if @doctor.update(doctor_params)
            redirect_to doctors_path, notice: "Doctor was updated successfully"
        else
            render :edit
        end
    end

    def destroy
        @doctor = Doctor.find(params[:id])
        if @doctor.destroy
            redirect_to doctors_path, notice: "Your doctor has been deleted"
        else
            redirect_to doctors_path, alert: "#{@doctor.errors.full_messages}"
        end
    end

    private

        def doctor_params
            params.require(:doctor).permit(:name, :crm, :crm_uf)
        end
end