class DropjenkinsTable < ActiveRecord::Migration
  def up
    drop_table :jenkins
  end
  def down 
    raise ActiveRecord::IrreversibleMigration
  end
end
