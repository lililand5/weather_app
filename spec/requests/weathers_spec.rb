# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Weathers', type: :request do
  let!(:weather) { create(:weather) }

  path '/weather/current' do
    get 'Return current temperature' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :number },
                 temperature: { type: :number }
               }

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(DateTime.parse(body[:time]).to_i).to eq(weather.local_time.to_i)
        end

        run_test!
      end
    end
  end
end
