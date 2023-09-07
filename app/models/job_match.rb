# frozen_string_literal: true

class JobMatch < ApplicationRecord
  before_validation :set_matching_skill_percent

  belongs_to :job
  belongs_to :job_seeker

  def jobseeker_id
    job_seeker.id
  end

  def jobseeker_name
    job_seeker.name
  end

  def job_id
    job.id
  end

  def job_title
    job.title
  end

  def matching_skill_count
    (job.skills & job_seeker.skills).length
  end

  def set_matching_skill_percent
    self.matching_skill_percent = calculate_matching_skill_percent
  end

  private

  def calculate_matching_skill_percent
    # To prevent division by 0
    0 if job.skills.empty?

    (matching_skill_count * 100 / job.skills.count)
  end
end
