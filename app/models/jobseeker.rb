# frozen_string_literal: true

class Jobseeker < ApplicationRecord
  has_many :job_skills, as: :skillable, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :job_matches, dependent: :destroy

  validates_presence_of :name

  def find_matches
    Job.select { |job| (job.skills & skills).any? }.each do |job|
      JobMatch.where(job_id: job.id, jobseeker_id: id).first_or_create
    end
  end

  def self.create_from_array(array)
    array.each do |row|
      jobseeker = Jobseeker.create(id: row[0], name: row[1])
      Skill.add_skills_to_record(jobseeker, row[2])
      jobseeker.find_matches
    end
  end
end
