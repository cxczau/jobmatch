# frozen_string_literal: true

require 'csv'

class JobMatchesController < ApplicationController
  before_action :load_records, only: %i[index]

  def index
    @job_matches = JobMatch.order(:job_seeker_id, [matching_skill_percent: :desc], :job_id)
    @jobs = Job.all
    @job_seekers = JobSeeker.all
  end

  private

  def load_records
    Job.destroy_all
    JobSeeker.destroy_all
    JobMatch.destroy_all

    job_data = CSV.read(Rails.root.join('lib/jobs.csv'))
    seeker_data = CSV.read(Rails.root.join('lib/jobseekers.csv'))

    Job.create_from_array(job_data[1..])
    JobSeeker.create_from_array(seeker_data[1..])
  end
end
