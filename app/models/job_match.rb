# frozen_string_literal: true

class JobMatch < ApplicationRecord
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
end
