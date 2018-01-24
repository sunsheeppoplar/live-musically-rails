class AddTimeframeOfPostToOpportunities < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :timeframe_of_post, :datetime
  end
end
