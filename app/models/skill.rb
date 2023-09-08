# frozen_string_literal: true

class Skill < ApplicationRecord
  validates_presence_of :name

  def self.parse_skills_string(skills_string)
    skills_string.split(',').map(&:strip)
  end

  def self.add_skills_to_record(record, skills)
    parse_skills_string(skills).each do |skill|
      found = Skill.find_by(name: skill)
      found = Skill.create(name: skill) if found.nil?
      record.skills << found
    end
  end
end
