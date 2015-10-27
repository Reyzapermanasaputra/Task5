class CreateMotors < ActiveRecord::Migration
  def change
    create_table :motors do |t|
      t.references :employee, index: true, foreign_key: true
      t.string :brand

      t.timestamps null: false
    end
  end
end
