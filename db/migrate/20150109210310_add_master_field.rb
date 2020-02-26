class AddMasterField < ActiveRecord::Migration[5.2]
  def change
    change_table :jenkins_hellos do |t|
      t.string :master
    end
  end
end
