RSpec.shared_context 'with personalization info' do
  let(:name_first) { "TestFirst" }
  let(:name_last) { "TestLast" }
  let(:phi_info) { PersonalizationService::PatientPHI.new(name_first, name_last) }

  before do
    allow(PersonalizationService).to receive(:fetch!).and_return(phi_info)
  end
end
