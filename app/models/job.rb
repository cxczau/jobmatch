# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_skills, as: :skillable, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :job_matches, dependent: :destroy

  validates_presence_of :title

  def find_matches
    Jobseeker.includes(:skills).select { |seeker| (seeker.skills & skills).any? }.each do |seeker|
      matching_skill_count = (seeker.skills & skills).length
      matching_skill_percent = (matching_skill_count * 100 / skills.count)
      JobMatch.create(job_id: id, jobseeker_id: seeker.id, matching_skill_percent:, matching_skill_count:)
    end
  end

  def self.create_from_array(array)
    array.each do |row|
      job = Job.create(id: row[0], title: row[1])
      Skill.add_skills_to_record(job, row[2])
      job.find_matches
    end
  end
end
