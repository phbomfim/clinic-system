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
      redirect_to patients_path, notice: "Patient has been created"
    else
      render :new, alert: "#{@patient.errors.full_messages}"
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      redirect_to patients_path, notice: "Patient was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @patient = Patient.find(params[:id])

    if @patient.destroy
      redirect_to patients_path, notice: "Patient has been deleted"
    else
      redirect_to patients_path, alert: "#{@patient.errors.full_messages}"
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :birth_date, :cpf)
  end
end
