# frozen_string_literal: true

module JobMatchesHelper
  def style_match_row(match)
    match.jobseeker_id.even? ? 'bg-white' : 'bg-grey'
  end

  def style_percent_text(percent)
    if percent >= 75
      'text-green'
    elsif percent >= 50
      'text-yellow'
    else
      'text-red'
    end
  end
end
