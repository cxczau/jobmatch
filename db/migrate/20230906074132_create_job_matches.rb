# frozen_string_literal: true

class CreateJobMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :job_matches, &:timestamps
  end
end
