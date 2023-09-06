# frozen_string_literal: true

require 'application_system_test_case'

class JobMatchesTest < ApplicationSystemTestCase
  setup do
    @job_match = job_matches(:one)
  end

  test 'visiting the index' do
    visit job_matches_url
    assert_selector 'h1', text: 'Job matches'
  end

  test 'should create job match' do
    visit job_matches_url
    click_on 'New job match'

    click_on 'Create Job match'

    assert_text 'Job match was successfully created'
    click_on 'Back'
  end

  test 'should update Job match' do
    visit job_match_url(@job_match)
    click_on 'Edit this job match', match: :first

    click_on 'Update Job match'

    assert_text 'Job match was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Job match' do
    visit job_match_url(@job_match)
    click_on 'Destroy this job match', match: :first

    assert_text 'Job match was successfully destroyed'
  end
end
