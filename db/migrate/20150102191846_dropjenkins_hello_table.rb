class DropjenkinsHelloTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :jenkins_hello
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
