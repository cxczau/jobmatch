# frozen_string_literal: true

require 'csv'

class JobMatchesController < ApplicationController
  def index
    if params[:reload]
      load_records
      redirect_to request.path
    end

    @job_matches = JobMatch.paginate(page: params[:page], per_page: 50).order(:jobseeker_id, [matching_skill_percent: :desc], :job_id)
  end

  private

  def load_records
    if params[:large]
      job_data = CSV.read(Rails.root.join('lib/jobs_large.csv'))
      seeker_data = CSV.read(Rails.root.join('lib/jobseekers_large.csv'))
    else
      job_data = CSV.read(Rails.root.join('lib/jobs.csv'))
      seeker_data = CSV.read(Rails.root.join('lib/jobseekers.csv'))
    end

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
