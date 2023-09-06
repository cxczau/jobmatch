# frozen_string_literal: true

class JobSeeker < ApplicationRecord
  has_many :job_skills, as: :skillable
  has_many :skills, through: :job_skills

  def personal_skills
    skills.map(&:name).sort.join(', ')
  end
end
