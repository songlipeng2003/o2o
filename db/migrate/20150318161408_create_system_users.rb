class CreateSystemUsers < ActiveRecord::Migration
  def change
    create_table :system_users do |t|
      t.string :code
      t.string :name

      t.timestamps
    end

    SystemUser.create code: 'platform', name: '平台账户'
    SystemUser.create code: 'company', name: '公司账户'
  end
end
