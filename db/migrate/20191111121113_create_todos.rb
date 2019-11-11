class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.text :description, null: false
      t.boolean :status, default: false
      t.date :schedule

      t.timestamps
    end
  end
end
