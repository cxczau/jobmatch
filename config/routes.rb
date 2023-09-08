# frozen_string_literal: true

Rails.application.routes.draw do
  resources :job_matches, only: %i[index]
  root to: 'job_matches#index'
end
