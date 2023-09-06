# frozen_string_literal: true

class JobMatchesController < ApplicationController
  # before_action :set_job_match, only: %i[ show edit update destroy ]
  before_action :load_records, only: %i[index]

  # GET /job_matches or /job_matches.json
  def index
    @job_matches = JobMatch.all
    @jobs = Job.all
    @job_seekers = JobSeeker.all
  end

  private

  def load_records
    Job.delete_all
    JobSeeker.delete_all

    job_data = CSV.read(Rails.root.join('lib/jobs.csv'))
    seeker_data = CSV.read(Rails.root.join('lib/jobseekers.csv'))

    job_data[1..].each do |row|
      job = Job.where(id: row[0], title: row[1]).first_or_create
      skills = row[2].split(',').map(&:strip)

      job.skills = []

      skills.each do |skill|
        job.skills << Skill.where(name: skill).first_or_create
      end
    end

    seeker_data[1..].each do |row|
      seeker = JobSeeker.where(id: row[0], name: row[1]).first_or_create
      skills = row[2].split(',').map(&:strip)

      seeker.skills = []

      skills.each do |skill|
        seeker.skills << Skill.where(name: skill).first_or_create
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job_match
    @job_match = JobMatch.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_match_params
    params.fetch(:job_match, {})
  end
end
