class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :nominal
      t.string :currency
      t.string :year
      t.belongs_to :coin_set, index: true

      t.timestamps null: false
    end
  end
end
