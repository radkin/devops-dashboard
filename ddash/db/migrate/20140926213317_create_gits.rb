class CreateGits < ActiveRecord::Migration
  def change
    create_table :gits do |t|
      t.string :sha
      t.string :owner
      t.string :repo
      t.string :host

      t.timestamps
    end
  end
end
