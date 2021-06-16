class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :starts_at, :ends_at, :doctor_id, :patient_id, presence: true
  validates_numericality_of :ends_at, :greater_than => :starts_at

  before_validation do
    defineEndTime
    inBusinessHours
    anotherAtThisTime
    throw(:abort) if errors.present?
  end

  # Check if the appointment has been completed
  def isFinished
    if self.ends_at < Time.now
      return  true
    else
      return false
    end
  end

  private

    # Use starts_at + 30 minutes define ends_at
    def defineEndTime
      self.ends_at = self.starts_at + 30.minutes
    end

    # Check if exists another appointment at this time
    def anotherAtThisTime 
      Appointment.all.each do |other|
        # A B A B
        if other.starts_at < self.ends_at && other.ends_at > self.ends_at && self != other
          errors.add(:base, 'Exists another appointment at this interval.')
        # B A B A
        elsif other.starts_at < self.starts_at && other.ends_at > self.starts_at && self != other
          errors.add(:base, 'Exists another appointment at this interval.')
        end
      end
    end

    # Check if the appointment is in the business hours
    def inBusinessHours
      starts = self.starts_at.strftime('%H:%M')
      ends = self.ends_at.strftime('%H:%M')
      if starts < '09:00'
        errors.add(:base, "MUITO CEDO: #{starts}")
      elsif ('11:30'..'12:59').cover?(starts)
        errors.add(:base, "ALMOÇO: #{starts}")
      elsif ('17:31'..'23:59').cover?(starts)
        errors.add(:base, "MUITO TARDE: #{starts}")
      end
    end
end
