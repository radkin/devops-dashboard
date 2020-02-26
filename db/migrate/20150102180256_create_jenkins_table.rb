class CreateJenkinsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :jenkins_hello do |t|
      t.string 'name'
      t.string 'url'
      t.string 'color'
    end
  end
end
