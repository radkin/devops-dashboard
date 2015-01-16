class CreateJenkinsTable < ActiveRecord::Migration
  def change
    create_table :jenkins_hello do |t|
      t.string 'name'
      t.string 'url'
      t.string 'color'
    end
  end
end
