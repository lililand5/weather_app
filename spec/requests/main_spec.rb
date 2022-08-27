# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Main', type: :request do
  path '/health' do
    get 'Return server status' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 status: { type: :string }
               }

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:status]).to eq('OK')
        end

        run_test!
      end
    end
  end
end
