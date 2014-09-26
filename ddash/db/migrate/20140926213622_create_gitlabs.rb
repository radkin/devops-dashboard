class CreateGitlabs < ActiveRecord::Migration
  def change
    create_table :gitlabs do |t|
      t.references :git, index: true
      t.integer :mr
      t.string :shas

      t.timestamps
    end
  end
end
