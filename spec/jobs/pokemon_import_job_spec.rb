# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonImportJob do
  describe '#perform' do
    it 'schedules job correctly' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        PokemonImportJob.perform_later
      end.to have_enqueued_job
    end
  end
end
