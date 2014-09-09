
shared_context 'custom current_user method' do
  after do
    Impressionist.setup { |mod| mod.current_user = nil }
  end

  before do
    Impressionist.setup do |mod|
      mod.current_user = -> {
        l0ser = Struct.new(:id)
        l0ser.id = custom_id
        l0ser
      }
    end
  end

  let(:custom_id) { 54321 }
end
