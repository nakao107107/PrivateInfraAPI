class AddApplicationCountToEntor < ActiveRecord::Migration[6.0]
  def change
    add_column :entors, :application_count, :integer
  end
end
