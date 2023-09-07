# frozen_string_literal: true

class JobSeeker < ApplicationRecord
  has_many :job_skills, as: :skillable, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :job_matches, dependent: :destroy

  def find_matches
    Job.select { |job| (job.skills & skills).any? }.each do |job|
      JobMatch.where(job_id: job.id, job_seeker_id: id).first_or_create
    end
  end

  def self.create_from_array(array)
    array.each do |row|
      seeker = JobSeeker.create(id: row[0], name: row[1])

      skills = row[2].split(',').map(&:strip)
      skills.each do |skill|
        seeker.skills << Skill.where(name: skill).first_or_create
      end

      seeker.find_matches
    end
  end
end
