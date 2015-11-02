class ChangeColumnFromComments < ActiveRecord::Migration
  def change
    rename_column :comments, :content, :comment
  end
end
