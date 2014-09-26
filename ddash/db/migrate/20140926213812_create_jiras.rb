class CreateJiras < ActiveRecord::Migration
  def change
    create_table :jiras do |t|
      t.string :ticket

      t.timestamps
    end
  end
end
