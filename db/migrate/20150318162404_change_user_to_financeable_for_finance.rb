class ChangeUserToFinanceableForFinance < ActiveRecord::Migration[4.2]
  def change
    change_table :finances do |t|
      t.rename :user_id, :financeable_id
      t.rename :user_type, :financeable_type
    end
  end
end
