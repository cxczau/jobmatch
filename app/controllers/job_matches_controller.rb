# frozen_string_literal: true

require 'csv'

class JobMatchesController < ApplicationController
  before_action :load_records, only: %i[index]

  def index
    @job_matches = JobMatch.all.sort_by{|e| [e.jobseeker_id, 100 - e.matching_skill_percent, e.job_id]}
    # @job_matches = JobMatch.order(:jobseeker_id, [matching_skill_percent: :desc], :job_id)
    @jobs = Job.all
    @jobseekers = Jobseeker.all
  end

  private

  def load_records
    job_data = CSV.read(Rails.root.join('lib/jobs.csv'))
    seeker_data = CSV.read(Rails.root.join('lib/jobseekers.csv'))

    return if job_data.empty? || seeker_data.empty?

    Job.destroy_all
    Jobseeker.destroy_all

    Job.create_from_array(job_data[1..])
    Jobseeker.create_from_array(seeker_data[1..])
  end
end
