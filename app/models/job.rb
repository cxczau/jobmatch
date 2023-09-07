# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_skills, as: :skillable, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :job_matches, dependent: :destroy

  validates_presence_of :title

  def self.create_from_array(array)
    array.each do |row|
      job = Job.create(id: row[0], title: row[1])
      Skill.add_skills_to_record(job, row[2])
    end
  end
end
