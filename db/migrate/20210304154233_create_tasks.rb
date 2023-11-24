class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :title
      t.text :description
      t.datetime :lastEditDate
      t.boolean :isDone

      t.timestamps
    end
  end
end
