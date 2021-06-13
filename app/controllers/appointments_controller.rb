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
            redirect_to appointments_path, notice: "Appointment has been created"
        else
            render :new, alert: "#{@appointment.errors.full_messages}"
        end
    end

    def edit
        @appointment = Appointment.find(params[:id])
    end

    def update
        @appointment = Appointment.find(params[:id])
        if @appointment.update(appointment_params)
            redirect_to appointments_path, notice: "Appointment was updated successfully"
        else
            render :edit
        end
    end

    def destroy
        @appointment = Appointment.find(params[:id])
        @appointment.destroy
        redirect_to appointments_path, notice: "Your appointment has been deleted"
    end

    private

        def appointment_params
            params.require(:appointment).permit(:starts_at, :ends_at, :patient_id, :doctor_id)
        end
end