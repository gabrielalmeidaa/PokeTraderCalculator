require "rails_helper"

RSpec.describe PokemonImportJob do
  
  describe "#perform" do
    it "schedules job correctly" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        PokemonImportJob.perform_later
      }.to have_enqueued_job
    end
  end
  
end