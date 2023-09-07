# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Jobseeker, type: :model do
  describe '#find_matches' do
    let(:skill) { Skill.create(name: 'independent') }
    let(:other_skill) { Skill.create(name: 'surfing') }
    let(:jobseeker) { Jobseeker.create(id: 1, name: 'Joe') }
    let(:job) { Job.create(id: 1, title: 'Developer') }
    before { job.skills << skill }

    shared_examples_for 'should not create a JobMatch' do
      it do
        expect(JobMatch.count).to eq(0)

        jobseeker.find_matches

        expect(JobMatch.count).to eq(0)
      end
    end

    context 'jobseeker has no skills' do
      it_behaves_like 'should not create a JobMatch'
    end

    context 'jobseeker has skills that match the Job' do
      before { jobseeker.skills << skill }
      it 'should create a JobMatch' do
        expect(jobseeker.job_matches.count).to eq(0)

        jobseeker.find_matches

        expect(jobseeker.job_matches.count).to eq(1)
        expect(jobseeker.job_matches.first.job_id).to eq(job.id)
      end
    end

    context 'jobseeker has skills that do not match the Job' do
      before { jobseeker.skills << other_skill }
      it_behaves_like 'should not create a JobMatch'
    end
  end

  describe '#create_from_array' do
    let(:csv_data) { [%w[1 name skills]] }

    it 'should create new Jobseekers' do
      expect(Jobseeker.count).to eq(0)
      expect(Skill).to receive(:add_skills_to_record).exactly(1).time
      expect_any_instance_of(Jobseeker).to receive(:find_matches).exactly(1).time
      Jobseeker.create_from_array(csv_data)

      expect(Jobseeker.count).to eq(1)
    end
  end
end
