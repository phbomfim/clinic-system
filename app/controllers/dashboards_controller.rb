class DashboardsController < ApplicationController

    def show 
        @doctors = Doctor.all
        
        if params[:filter].nil? || params[:filter] == "all"
            @patients = Patient.all 
            @appointments = Appointment.all
        else
            @appointments = Appointment.where(doctor_id: params[:filter])
            @patients = Patient.all
        end
    end

    private 

        def dashboards_params
            params.require(:dashboard).permit(:filter, :doctor_id)
        end
end