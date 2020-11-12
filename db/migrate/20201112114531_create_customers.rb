class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.string :created_by
      t.string :last_update_by
      t.timestamps
    end
  end
end
