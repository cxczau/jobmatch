# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_06_094132) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_matches", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "jobseeker_id"
    t.integer "matching_skill_count"
    t.float "matching_skill_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id", "jobseeker_id"], name: "index_job_matches_on_job_id_and_jobseeker_id"
    t.index ["job_id"], name: "index_job_matches_on_job_id"
    t.index ["jobseeker_id", "job_id"], name: "index_job_matches_on_jobseeker_id_and_job_id"
    t.index ["jobseeker_id"], name: "index_job_matches_on_jobseeker_id"
  end

  create_table "job_skills", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "skillable_id"
    t.string "skillable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skillable_id", "skillable_type"], name: "index_job_skills_on_skillable_id_and_skillable_type"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobseekers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

end
