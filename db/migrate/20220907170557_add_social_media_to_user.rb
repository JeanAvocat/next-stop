class AddSocialMediaToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :social_media
    add_column :users, :phone_number, :string
    add_column :users, :instagram_account, :string
  end
end
