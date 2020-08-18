class CreateTables < ActiveRecord::Migration[6.0]
  def change

    create_table :events, id: :string do |t|
      t.string :name
      t.string :hp_url
      t.string :slack_url
      t.string :recommend_text
      t.datetime :deadline
      t.timestamps
    end

    create_table :event_industries do |t|
      t.string :event_id
      t.string :industry_id
      t.timestamps
    end

    create_table :event_occupations do |t|
      t.string :event_id
      t.string :occupation_id
      t.timestamps
    end

    create_table :progresses do |t|
      t.string :mentor_id
      t.string :event_id
      t.string :status
      t.timestamps
    end

    create_table :applications do |t|
      t.string :entor_id
      t.string :event_id
      t.datetime :applicated_at
      t.timestamps
    end

    create_table :mentors, id: :string do |t|
      t.string :name
      t.string :login_id
      t.string :password_digest
      t.string :access_token
      t.timestamps
    end

    create_table :entors, id: :string do |t|
      t.string :name
      t.string :mentor_id
      t.string :nickname
      t.timestamps
    end

    create_table :industries do |t|
      t.string :name
      t.timestamps
    end

    create_table :entor_industries do |t|
      t.string :entor_id
      t.string :industry_id
      t.timestamps
    end

    create_table :occupations do |t|
      t.string :name
      t.timestamps
    end

    create_table :entor_occupations do |t|
      t.string :entor_id
      t.string :occupation_id
      t.timestamps
    end

    create_table :appeals do |t|
      t.string :entor_id
      t.string :mentor_id
      t.string :event_id
      t.timestamps
    end
  end
end
