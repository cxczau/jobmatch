# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobMatchesController, type: :controller do
  describe '#index' do
    it 'should render index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#load_records' do
    let(:csv_headers) { [%w[id title description skills]] }
    let(:csv_data) { [%w[1 name skills], %w[2 name skills]] }
    let(:csv_mock) { csv_headers + csv_data }

    context 'csv files are empty' do
      it 'should not load records' do
        expect(CSV).to receive(:read).exactly(2).times.and_return([])
        expect(Job).not_to receive(:destroy_all)
        expect(JobSeeker).not_to receive(:destroy_all)
        expect(Job).not_to receive(:create_from_array)
        expect(JobSeeker).not_to receive(:create_from_array)

        JobMatchesController.new.send(:load_records)

        expect(Job.count).to eq(0)
        expect(JobSeeker.count).to eq(0)
      end
    end

    context 'csv files are not empty' do
      it 'should delete existing records' do
        expect(Job).to receive(:destroy_all)
        expect(JobSeeker).to receive(:destroy_all)

        JobMatchesController.new.send(:load_records)
      end

      it 'should create new Jobs and Job Seekers' do
        expect(CSV).to receive(:read).exactly(2).times.and_return(csv_mock)
        expect(Job).to receive(:create_from_array).with(csv_data)
        expect(JobSeeker).to receive(:create_from_array).with(csv_data)

        JobMatchesController.new.send(:load_records)
      end
    end
  end
end
