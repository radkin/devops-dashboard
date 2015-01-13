class AddMasterField < ActiveRecord::Migration
  def change
    change_table :jenkins_hellos do |t|
      t.string :master
    end
  end
end
