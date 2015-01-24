class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :order, index: true
      t.integer :score
      t.string :note

      t.datetime :created_at
    end
  end
end
