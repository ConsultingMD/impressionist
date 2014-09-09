
shared_context 'custom current_user proc' do
  after do
    Impressionist.setup { |mod| mod.current_user = nil }
  end

  before do
    Impressionist.setup { |mod| mod.current_user = lambda_callback }
  end

  let(:lambda_callback) do
    -> {
      l0ser = OpenStruct.new(:id => custom_user)
      l0ser
    }
  end
  let(:custom_user) { 54321 }
end

shared_context 'custom current_user method' do
  after do
    Impressionist.setup { |mod| mod.current_user = nil }
  end

  before do
    Impressionist.setup { |mod| mod.current_user = symbol_callback }
  end

  let(:symbol_callback) do
    class ApplicationController
      def funky_user_test
        l0ser = OpenStruct.new(:id => 10203)
        l0ser
      end
    end
    :funky_user_test
  end

  let(:custom_user) { 10203 }
end
