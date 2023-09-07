# frozen_string_literal: true

module SkillablesHelper
  def stringify_skills(skills)
    skills.map(&:name).sort.join(', ')
  end
end
