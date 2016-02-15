class CreateCoinSets < ActiveRecord::Migration
  def change
    create_table :coin_sets do |t|
      t.string :years
      t.belongs_to :country, index: true

      t.timestamps null: false
    end
  end
end
