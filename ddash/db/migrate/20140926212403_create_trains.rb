class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.string :git_commit
      t.references :jenkins, index: true
      t.references :svn, index: true
      t.references :git, index: true
      t.references :gerrit, index: true
      t.references :gitlab, index: true
      t.references :jira, index: true
      t.datetime :depart
      t.datetime :arrive
      t.references :train_route, index: true

      t.timestamps
    end
  end
end
