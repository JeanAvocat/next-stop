class AddStatusString < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :status, :string
  end
end
