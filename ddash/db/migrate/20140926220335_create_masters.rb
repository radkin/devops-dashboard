class CreateMasters < ActiveRecord::Migration
  def change
    create_table :masters do |t|
      t.string :master
      t.string :url
      t.integer :total_success
      t.integer :total_failed
      t.references :slaves, index: true

      t.timestamps
    end
  end
end
