# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_skills, as: :skillable, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :job_matches, dependent: :destroy

  def self.create_from_array(array)
    array.each do |row|
      job = Job.create(id: row[0], title: row[1])

      skills = row[2].split(',').map(&:strip)
      skills.each do |skill|
        job.skills << Skill.where(name: skill).first_or_create
      end
    end
  end
end
