# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Weathers', type: :request do
  let!(:weather_one) { create(:weather, epoch_time: (Time.now - 1.hours).to_i, temperature: 0) }
  let!(:weather_two) { create(:weather, epoch_time: (Time.now - 2.hours).to_i, temperature: 10) }
  let!(:weather_three) { create(:weather, epoch_time: (Time.now - 3.hours).to_i, temperature: 20) }

  path '/weather/current' do
    get 'Return current temperature' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :string },
                 temperature: { type: :number }
               },
               required: %i[
                 time
                 temperature
               ]

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(DateTime.parse(body[:time]).to_i).to eq(weather_three.local_time.to_i)
        end

        run_test!
      end
    end
  end

  path '/weather/historical' do
    get 'Return last 24 temperature' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   time: { type: :string },
                   temperature: { type: :number }
                 },
                 required: %i[
                   time
                   temperature
                 ]
               }

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body.first[:temperature]).to eq(weather_one.temperature)
        end

        run_test!
      end
    end
  end

  path '/weather/historical/max' do
    get 'Return the maximum temperature for the last 24 hours' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :string },
                 temperature: { type: :number }
               },
               required: %i[
                 time
                 temperature
               ]

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:temperature]).to eq(weather_three.temperature)
        end

        run_test!
      end
    end
  end

  path '/weather/historical/min' do
    get 'Return the minimum temperature for the last 24 hours' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :string },
                 temperature: { type: :number }
               },
               required: %i[
                 time
                 temperature
               ]

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:temperature]).to eq(weather_one.temperature)
        end

        run_test!
      end
    end
  end

  path '/weather/historical/avg' do
    get 'Return the average temperature for the last 24 hours' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :number

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body).to eq(weather_two.temperature)
        end

        run_test!
      end
    end
  end

  path '/weather/by_time' do
    parameter name: 'unix_time', in: :query, type: :string, description: 'date from client'
    let(:unix_time) { weather_two.epoch_time }

    get 'Return temperature by time' do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 time: { type: :string },
                 temperature: { type: :number }
               },
               required: %i[
                 time
                 temperature
               ]

        after do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:temperature]).to eq(weather_two.temperature)
        end

        run_test!
      end
    end
  end
end
