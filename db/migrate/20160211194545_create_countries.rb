class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.belongs_to :continent, index: true

      t.timestamps null: false
    end
  end
end
