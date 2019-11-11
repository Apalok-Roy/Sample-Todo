class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 100, index: { unique: true }
      t.string :password, null: false
      t.string :password_confirmation, null: false

      t.timestamps
    end
  end
end
