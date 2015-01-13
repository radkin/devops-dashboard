class RemoveUpdatedAtField < ActiveRecord::Migration
  def change
    change_table :jenkins_hellos do |t|
      t.remove :updated_at
    end
  end
end
