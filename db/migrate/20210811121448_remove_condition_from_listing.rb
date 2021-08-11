class RemoveConditionFromListing < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :condition, :integer
  end
end
