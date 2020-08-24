class AddColumnEntor < ActiveRecord::Migration[6.0]
  def change
    add_column :entors, :company_type, :string
    add_column :events, :company_type, :string
  end
end
