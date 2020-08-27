class AddLgTextColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :lg_text, :string
  end
end
