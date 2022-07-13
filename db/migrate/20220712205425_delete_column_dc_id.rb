class DeleteColumnDcId < ActiveRecord::Migration[7.0]
  def up
      remove_column :users, :documentNumber_id
  end
end
