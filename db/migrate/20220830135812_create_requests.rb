class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :status
      t.references :sender, null: false, foreign_key: {to_table: :users}
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
