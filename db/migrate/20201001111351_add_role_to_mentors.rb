class AddRoleToMentors < ActiveRecord::Migration[6.0]
  def change
    add_column :mentors, :role, :string
  end
end
