# frozen_string_literal: true

class JobSkill < ApplicationRecord
  belongs_to :skillable, polymorphic: true
  belongs_to :skill
end
