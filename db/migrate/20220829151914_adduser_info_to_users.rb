class AdduserInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firt_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :random_nickname, :string
    add_column :users, :social_media, :string
    add_column :users, :score, :integer
  end
end
