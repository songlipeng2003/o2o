class DeleteTitleFromFeedbacks < ActiveRecord::Migration
  def change
    change_table :feedbacks do |t|
      t.remove :title
      t.change :feedback_type, :integer
    end
  end
end
