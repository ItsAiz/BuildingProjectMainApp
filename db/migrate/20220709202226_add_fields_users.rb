class AddFieldsUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :documentNumber, :string, :null => false, :unique =>  true
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #add_reference :users, :documentNumber, foreign_key: true
  end
end
