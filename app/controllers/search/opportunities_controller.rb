class Search::OpportunitiesController < ApplicationController
	def new
		@opportunity_search_form = OpportunitiesSearchForm.new
	end

	def index
		@opportunities_search_form = OpportunitiesSearchForm.new(opportunities_search_params)
		query_base = Opportunity.includes(:artist_opportunities, :employer, :venue).where('timeframe_of_post >= ?', DateTime.now)
		basic_opportunities_query = BasicOpportunitiesQuery.new(scope:  query_base, params: @opportunities_search_form).call
		@opportunity_query_decorator = OpportunityDecorator.wrap(basic_opportunities_query)
	end

	private
	def opportunities_search_params
		params.require(:opportunities_search_form).permit(:event_start_time, :event_start_date, :event_end_time, :event_end_date, :instrument, :location)
	end
end
