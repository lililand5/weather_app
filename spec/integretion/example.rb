# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'to get data', type: :feature do
  scenario 'valid inputs' do
    visit '/health'
    expect(page.body).to have_content('{"status":"OK"}')
  end
end
