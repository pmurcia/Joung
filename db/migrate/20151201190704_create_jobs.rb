class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :name
      t.string :description

      t.integer :salary
      t.integer :rating
      t.date :start_date
      t.date :finish_date
      t.string :location


      t.timestamps null: false
    end
  end
end