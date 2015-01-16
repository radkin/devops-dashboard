class DropjenkinsHelloTable < ActiveRecord::Migration
  def up
    drop_table :jenkins_hello
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
