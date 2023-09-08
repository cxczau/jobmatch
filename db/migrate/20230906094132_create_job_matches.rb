# frozen_string_literal: true

class CreateJobMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :job_matches do |t|
      t.references :job, index: true
      t.references :jobseeker, index: true
      t.integer :matching_skill_count
      t.float :matching_skill_percent
      t.timestamps
      t.index %w[job_id jobseeker_id]
      t.index %w[jobseeker_id job_id]
    end
  end
end
