require 'spec_helper'

describe Impressionist do
  let(:imp) { RUBY_VERSION.match("1.8") ? "is_impressionable" : :is_impressionable }

  it "should be extended from ActiveRecord::Base" do
    expect(ActiveRecord::Base).to respond_to(imp)
    #ActiveRecord::Base.methods.include?(method).should be_true
  end

  it "should include methods in ApplicationController" do
    method = RUBY_VERSION.match("1.8") ? "impressionist" : :impressionist
    expect(ApplicationController).to respond_to(method)
  end

  it "should include the before_filter method in ApplicationController" do
     filters = ApplicationController._process_action_callbacks.select { |c| c.kind == :before }
     filters.collect{|filter|filter.filter}.include?(:impressionist_app_filter).should be_true
  end

  describe '#current_user=' do
    context 'with a method symbol' do
      include_context 'custom current_user method'

      it 'can be configured' do
        expect(Impressionist.current_user).to_not be_nil
      end
    end

    context 'with a proc' do
      include_context 'custom current_user proc'

      it 'can be configured with a symbol' do
        expect(Impressionist.current_user).to_not be_nil
      end
    end
  end
end
