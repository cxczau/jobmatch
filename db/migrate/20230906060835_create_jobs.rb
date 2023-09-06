# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.timestamps
    end

    create_table :job_seekers do |t|
      t.string :name
      t.timestamps
    end

    create_table :skills do |t|
      t.string :name
      t.timestamps
    end

    add_index :skills, :name, unique: true
  end
end
