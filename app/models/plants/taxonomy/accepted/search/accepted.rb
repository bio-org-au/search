#  Search for scientific names
class Plants::Taxonomy::Accepted::Search::Accepted
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    name_search.lower_simple_name_like(@parsed.search_term)
  end

  def full_name_search
    name_search.lower_full_name_like(@parsed.search_term)
  end

  def name_search
    Name.accepted_tree_accepted_search
  end
end
