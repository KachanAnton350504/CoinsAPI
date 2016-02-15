class CreateUsersAndCoins < ActiveRecord::Migration
  def change
    create_join_table :coins, :users do |t|
      t.index :coin_id
      t.index :user_id
    end
  end
end
