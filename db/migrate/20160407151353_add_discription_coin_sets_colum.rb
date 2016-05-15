class AddDiscriptionCoinSetsColum < ActiveRecord::Migration
  def change
    add_column :coin_sets, :discription, :text
  end
end
