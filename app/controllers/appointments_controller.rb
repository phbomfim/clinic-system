class AppointmentsController < ApplicationController
    def index
        @appointments = Appointment.all
    end

    def new
        @appointment = Appointment.new
    end

    def create
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
            redirect_to appointments_path
        else
            render :new
        end
    end

    def update
    end

    def delete
    end

    private

        def appointment_params
            params.require(:appointment).permit(:starts_at, :ends_at, :patient_id, :doctor_id)
        end
end