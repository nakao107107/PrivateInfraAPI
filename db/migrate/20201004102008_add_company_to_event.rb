class AddCompanyToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :company, :string
  end
end
