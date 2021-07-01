class ChangeIsUserNameDefaultOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :username, from: "", to: nil 
  end
end
