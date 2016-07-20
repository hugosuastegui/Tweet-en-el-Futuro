class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.string :job_id
      t.belongs_to :twitter_user
      t.timestamps
    end
  end
end
