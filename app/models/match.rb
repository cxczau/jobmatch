# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :job
  belongs_to :job_seeker

  def matching_skill_count
    1
  end

  def matching_skill_percent
    return 0 if job.skills.count.zero?

    matching_skill_count / job.skills.count
  end
end
