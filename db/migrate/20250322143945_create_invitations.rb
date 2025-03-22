class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: true
      t.string :code

      t.timestamps
    end

    add_index :invitations, %i[code], unique: true
  end
end
