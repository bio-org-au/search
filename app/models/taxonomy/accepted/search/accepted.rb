# frozen_string_literal: true
#  Search for scientific names
class Taxonomy::Accepted::Search::Accepted
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Accepted Name"
  def initialize(params, default_show_results_as: "details")
    @parsed = Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as
    )
    @results = search.name_matches(@parsed.search_term)
  end

  def search
    AcceptedName.accepted.ordered
                .includes(:status)
                .includes(:rank)
                .includes(:names)
                .includes(:reference)
                .includes(:instance).includes(:instance_types)
                .includes(:instance_note_keys)
                .includes(:synonyms).includes(:cites)
                .includes(:cite_references)
  end
end
