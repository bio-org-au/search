class Plants::Taxonomy::Accepted::Search::ExcludedController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Taxonomy::Accepted::Search::Excluded.new(
        params,
        default_show_results_as: session[:default_show_results_as])
    end
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def set_zone
    @zone = "plants"
  end
end