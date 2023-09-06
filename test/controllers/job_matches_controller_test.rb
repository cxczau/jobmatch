# frozen_string_literal: true

require 'test_helper'

class JobMatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_match = job_matches(:one)
  end

  test 'should get index' do
    get job_matches_url
    assert_response :success
  end

  test 'should get new' do
    get new_job_match_url
    assert_response :success
  end

  test 'should create job_match' do
    assert_difference('JobMatch.count') do
      post job_matches_url, params: { job_match: {} }
    end

    assert_redirected_to job_match_url(JobMatch.last)
  end

  test 'should show job_match' do
    get job_match_url(@job_match)
    assert_response :success
  end

  test 'should get edit' do
    get edit_job_match_url(@job_match)
    assert_response :success
  end

  test 'should update job_match' do
    patch job_match_url(@job_match), params: { job_match: {} }
    assert_redirected_to job_match_url(@job_match)
  end

  test 'should destroy job_match' do
    assert_difference('JobMatch.count', -1) do
      delete job_match_url(@job_match)
    end

    assert_redirected_to job_matches_url
  end
end
