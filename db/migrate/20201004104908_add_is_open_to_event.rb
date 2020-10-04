class AddIsOpenToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :is_open, :boolean
  end
end
