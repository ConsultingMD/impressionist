# This controller imports the impressionist module to make the modules methods available for testing
class OverrideController < ActionController::Base

  before_filter { @override = Article.find(params[:id]) if params.include?(:id) }

  impressionist :query_params => { :controller_name => 'An::Arbitrary::String', :impressionable_type => :Article }

  def index
  end

  def show
  end
end
