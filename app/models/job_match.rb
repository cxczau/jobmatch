# frozen_string_literal: true

class JobMatch < ApplicationRecord
  before_validation :set_matching_skill_percent

  belongs_to :job
  belongs_to :jobseeker

  def jobseeker_id
    jobseeker.id
  end

  def jobseeker_name
    jobseeker.name
  end

  def job_id
    job.id
  end

  def job_title
    job.title
  end

  def matching_skill_count
    (job.skills & jobseeker.skills).length
  end

  def set_matching_skill_percent
    self.matching_skill_percent = calculate_matching_skill_percent
  end

  private

  def calculate_matching_skill_percent
    # To prevent division by 0
    return 0 if job.skills.empty?

    (matching_skill_count * 100 / job.skills.count)
  end
end
