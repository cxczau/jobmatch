# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobMatch, type: :model do
  let(:skill) { Skill.create(id: 1, name: 'Ruby') }
  let(:job) { Job.create(id: 1, title: 'Developer') }
  let(:jobseeker) { Jobseeker.create(id: 1, name: 'Joe1') }

  describe '#matching_skill_count' do
    subject { JobMatch.new(job_id: job.id, jobseeker_id: jobseeker.id) }

    context 'Job has no Skills' do
      it 'should return 0' do
        subject.save

        expect(subject.matching_skill_count).to eq(0)
      end
    end

    context 'Jobseeker has one of the Skills on the Job' do
      before { job.skills << skill }
      before { jobseeker.skills << skill }
      it 'should return 1' do
        subject.save

        expect(subject.matching_skill_count).to eq(1)
      end
    end
  end
end
