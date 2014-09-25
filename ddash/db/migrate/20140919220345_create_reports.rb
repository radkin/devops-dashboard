class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
