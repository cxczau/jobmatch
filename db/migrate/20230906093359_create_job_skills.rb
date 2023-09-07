# frozen_string_literal: true

class CreateJobSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :job_skills do |t|
      t.integer :skill_id
      t.integer :skillable_id
      t.string :skillable_type
      t.timestamps
    end
    add_index :job_skills, %i[skillable_id skillable_type]
  end
end
