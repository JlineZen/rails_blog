class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.datetime :birthday
      t.string :gender
      t.integer :is_admin
      t.string :nick_name
    end
  end
end
