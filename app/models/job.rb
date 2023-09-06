# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_skills, as: :skillable
  has_many :skills, through: :job_skills

  def required_skills
    skills.map(&:name).sort.join(', ')
  end
end
