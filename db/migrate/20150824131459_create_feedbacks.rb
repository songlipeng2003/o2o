class CreateFeedbacks < ActiveRecord::Migration[4.2]
  def change
    create_table :feedbacks do |t|
      t.references :user, index: true
      t.references :application, index: true
      t.string :title
      t.text :content
      t.string :feedback_type

      t.timestamps
    end
  end
end
