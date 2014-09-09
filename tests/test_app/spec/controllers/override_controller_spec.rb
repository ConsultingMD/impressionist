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

  shared_examples_for 'impressionable' do |article|
    let(:impression) { Impression.last }

    it 'logs the arbitrary data' do
      impression.controller_name.should == controller_name
    end

    it 'refers to the right model instance' do
      impression.impressionable.should == article
    end
  end

  describe '#show' do
    let(:controller_name) { 'An::Arbitrary::String' }

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

  describe '#update' do
    let(:controller_name) { 'A::Different::String' }

    context 'with an arbitrary object' do
      before { put "update", :id => Article.first.id }

      it_behaves_like 'impressionable', Article.first
    end
  end
end
