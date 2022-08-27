# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Weathers', type: :request do
  path '/weather/current' do
    get 'Return current temperature' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 current_temp: { type: :string }
               }

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:current_temp]).to eq('00')
        end

        run_test!
      end
    end
  end
end
