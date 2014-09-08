require 'spec_helper'

describe OverrideController do
  fixtures :articles
  render_views

  describe '#index' do
    it "should log impression with arbitrary query data" do
      get "index"
      Impression.last.controller_name.should == 'An::Arbitrary::String'
    end
  end

  describe '#show' do

    shared_examples_for 'impressionable' do |article|
      let(:impression) { Impression.last }

      it 'logs the arbitrary data' do
        impression.controller_name.should == 'An::Arbitrary::String'
      end

      it 'refers to the right model instance' do
        impression.impressionable.should == article
      end
    end

    context 'with an arbitrary object' do
      before { get "show", :id => Article.first.id }

      it_behaves_like 'impressionable', Article.first

      # To make sure the data structures aren't permanently munge!d
      context 'and another one' do
        before { get "show", :id => Article.last.id }

        it_behaves_like 'impressionable', Article.last
      end
    end
  end
end
