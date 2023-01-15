class CreateAdminEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_emails do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
