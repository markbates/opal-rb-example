class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :todos, :completed
  end
end
