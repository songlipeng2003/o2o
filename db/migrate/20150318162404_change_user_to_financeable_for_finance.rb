class ChangeUserToFinanceableForFinance < ActiveRecord::Migration
  def change
    change_table :finances do |t|
      t.rename :user_id, :financeable_id
      t.rename :user_type, :financeable_type
    end
  end
end
