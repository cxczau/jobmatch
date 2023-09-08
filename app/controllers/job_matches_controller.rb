# frozen_string_literal: true

require 'csv'

class JobMatchesController < ApplicationController
  before_action :load_records, only: %i[index]

  def index
    @job_matches = JobMatch.order(:jobseeker_id, [matching_skill_percent: :desc], :job_id).first(100)
  end

  private

  def load_records
    job_data = CSV.read(Rails.root.join('lib/jobs_large.csv'))
    seeker_data = CSV.read(Rails.root.join('lib/jobseekers_large.csv'))
    # job_data = CSV.read(Rails.root.join('lib/jobs.csv'))
    # seeker_data = CSV.read(Rails.root.join('lib/jobseekers.csv'))

    return if job_data.empty? || seeker_data.empty?

    # delete_all is faster than destroy_all, but misses dependent records
    Job.delete_all
    Jobseeker.delete_all
    JobMatch.delete_all
    JobSkill.delete_all

    Job.create_from_array(job_data[1..])
    Jobseeker.create_from_array(seeker_data[1..])
  end
end
