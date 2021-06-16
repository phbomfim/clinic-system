class DashboardsController < ApplicationController
    protect_from_forgery except: :show

    def show 
        
        @doctors = Doctor.all

        if params[:filter].nil? || params[:filter] == "all"
            @doctor = "All doctors"
            @patients = Patient.count
            @appointments = Appointment.select{|ap| ap.isFinished? }
            @appointments = @appointments.count
        else
            @doctor = Doctor.find(params[:filter]).name
            @appointments = Appointment.where(doctor_id: params[:filter])
            @patients = @appointments.distinct.count(:patient_id)
            @appointments = @appointments.select{|ap| ap.isFinished? }
            @appointments = @appointments.count
        end
    end

    private 

        def dashboards_params
            params.require(:dashboard).permit(:filter, :doctor_id)
        end
end