# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '#create_from_array' do
    let(:csv_data) { [%w[1 name skills]] }

    it 'should create new Jobs' do
      expect(Job.count).to eq(0)
      expect(Skill).to receive(:add_skills_to_record).exactly(1).time
      Job.create_from_array(csv_data)

      expect(Job.count).to eq(1)
    end
  end
end
