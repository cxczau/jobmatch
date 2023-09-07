# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe '#add_skills_to_record' do
    let(:input_mock) { double('input_mock') }
    let(:skills_array) { ['independent'] }
    let(:job) { Job.create(id: 1, title: 'Developer') }
    let(:jobseeker) { Jobseeker.create(id: 1, name: 'Joe') }

    shared_examples_for 'should create new Skill and add it to the record' do
      it do
        expect(Skill.count).to eq(0)
        expect(record.skills.count).to eq(0)

        Skill.add_skills_to_record(record, input_mock)

        expect(Skill.count).to eq(1)
        expect(record.skills.count).to eq(1)
      end
    end

    shared_examples_for 'should not create new Skill then add it to the record' do
      let!(:skill) { Skill.create(name: 'independent') }
      it do
        expect(Skill.count).to eq(1)
        expect(record.skills.count).to eq(0)

        Skill.add_skills_to_record(record, input_mock)

        expect(Skill.count).to eq(1)
        expect(record.skills.count).to eq(1)
      end
    end

    before { expect(Skill).to receive(:parse_skills_string).and_return(skills_array) }

    context 'skill does not exist and record is Job type' do
      let(:record) { job }
      it_behaves_like 'should create new Skill and add it to the record'
    end

    context 'skill does not exist and record is Job type' do
      let(:record) { jobseeker }
      it_behaves_like 'should create new Skill and add it to the record'
    end

    context 'skill already exists and record is Job type' do
      let(:record) { job }
      it_behaves_like 'should not create new Skill then add it to the record'
    end

    context 'skill already exists and record is Job type' do
      let(:record) { jobseeker }
      it_behaves_like 'should not create new Skill then add it to the record'
    end
  end
end
