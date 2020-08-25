class AddGroupColumnMentor < ActiveRecord::Migration[6.0]
  def change
    add_column :mentors, :group, :string
  end
end
