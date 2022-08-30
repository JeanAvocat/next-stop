class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :status
      t.references :creator, null: false, foreign_key: {to_table: :users}
      t.references :joiner, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
