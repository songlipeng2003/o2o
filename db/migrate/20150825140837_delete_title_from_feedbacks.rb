class DeleteTitleFromFeedbacks < ActiveRecord::Migration[4.2]
  def change
    change_table :feedbacks do |t|
      t.remove :title
      t.change :feedback_type, :integer
    end
  end
end
