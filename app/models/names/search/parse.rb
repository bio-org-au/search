# frozen_string_literal: true

# Rails model
class Names::Search::Parse
  attr_reader :search_type,
              :search_term,
              :show_as,
              :limit

  SIMPLE_SEARCH = "Search"
  SHOW_DETAILS = "details"
  SHOW_LIST = "list"
  DEFAULT_LIST_LIMIT = 1000
  DEFAULT_DETAILS_LIMIT = 3

  def initialize(params, info = {})
    @params = params
    @info = info
    @search_type = search_type
    @search_term = search_term
    @show_as = show_as
    @limit = limit
  end

  def search_type
    if @info.key?(:search_type)
      "#{@info[:search_type]} Search"
    else
      SIMPLE_SEARCH
    end
  end

  def add_trailing_wildcard
    return "true" unless @params.key?(:add_trailing_wildcard)
    @params[:add_trailing_wildcard]
  end

  def search_term
    term = @params[:q].strip.tr("*", "%")
    return term unless add_trailing_wildcard.start_with?("t")
    term.sub(/$/, "%")
  end

  def show_as
    @params[:show_results_as] || @info[:default_show_results_as] || SHOW_LIST
  end

  def limit
    if list?
      DEFAULT_LIST_LIMIT
    else
      DEFAULT_DETAILS_LIMIT
    end
  end

  def list?
    @show_as == SHOW_LIST
  end

  def show_list?
    list?
  end

  def details?
    @show_as == SHOW_DETAILS
  end

  def show_details?
    details?
  end
end
