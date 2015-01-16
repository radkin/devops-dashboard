class CreateJenkinsHellos < ActiveRecord::Migration
  def change
    create_table :jenkins_hellos do |t|
      t.string 'name'
      t.string 'url'
      t.string 'color'
      t.timestamps
    end
  end
end
