class AddFieldDocumentNumberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :documentNumber, :string, :null => false, :unique =>  true
  end
end
