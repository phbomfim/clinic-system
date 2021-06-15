class DashboardsController < ApplicationController
    protect_from_forgery except: :show

    def show 
        @doctors = Doctor.all

        if params[:filter].nil? || params[:filter] == "all"
            @patients = Patient.count
            @appointments = Appointment.select{|ap| ap.isFinished }
            @appointments = @appointments.count
        else
            @appointments = Appointment.where(doctor_id: params[:filter])
            @patients = @appointments.distinct.count(:patient_id)
            @appointments = @appointments.select{|ap| ap.isFinished }
            @appointments = @appointments.count
        end
    end

    private 

        def dashboards_params
            params.require(:dashboard).permit(:filter, :doctor_id)
        end
end