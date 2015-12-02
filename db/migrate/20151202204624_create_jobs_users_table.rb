class CreateJobsUsersTable < ActiveRecord::Migration
  def change
    create_table :jobs_users, id: false do |t|
      t.belongs_to :job
      t.belongs_to :user
    end
  end
end
