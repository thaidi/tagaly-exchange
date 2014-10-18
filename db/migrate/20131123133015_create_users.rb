class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
	t.string :usertype
      t.string :firstname
      t.string :lastname
      t.string :user_timezone
      t.string :reset_password_token
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
