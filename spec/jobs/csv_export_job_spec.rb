require 'rails_helper'

RSpec.describe CsvExportJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }

  before do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe "queueing" do
    it "enqueues the job correctly" do
      expect {
        CsvExportJob.perform_later(user.id)
      }.to have_enqueued_job(CsvExportJob).with(user.id).on_queue("delayed")
    end
  end

  describe "execution" do
    it "executes perform without error" do
      expect {
        CsvExportJob.perform_now(user.id)
      }.not_to raise_error
    end
  end
end