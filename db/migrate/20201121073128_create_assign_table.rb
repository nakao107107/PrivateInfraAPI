class CreateAssignTable < ActiveRecord::Migration[6.0]
  def change
    create_table :assigns do |t|
      t.string :mentor_id
      t.string :event_id
      t.timestamps
    end
  end
end
