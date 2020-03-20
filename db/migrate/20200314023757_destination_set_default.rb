class DestinationSetDefault < ActiveRecord::Migration[6.0]
  def up
    change_column :destinations, :review_rank, :decimal, default: 0.0
    change_column :destinations, :review_num, :integer, default: 0
  end

  def down
    change_column :destinations, :review_rank, :decimal
    change_column :destinations, :review_num, :integer
  end
end
