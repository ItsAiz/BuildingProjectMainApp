class AddUserToPropietario < ActiveRecord::Migration[7.0]
  def change
    add_reference :propietarios, :user, null: true, foreign_key: true
  end
end
