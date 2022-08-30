# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Weathers', type: :request do
  let!(:weather) { create(:weather) }
  # let!(:list_last_weathers) { create(:list_last_weathers) }

  path '/weather/current' do
    get 'Return current temperature' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :string },
                 temperature: { type: :float}
               }

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          # expect(body[:time]).to eq(weather.local_time)

          # pp DateTime.parse(weather.local_time)

          pp weather.local_time.to_s

          pp DateTime.parse(body[:time]).to_s

          # pp list_last_weathers
        end

        run_test!
      end
    end
  end
end
