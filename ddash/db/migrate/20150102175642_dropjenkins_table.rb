class DropjenkinsTable < ActiveRecord::Migration
  def up
    drop_table :jenkins
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
