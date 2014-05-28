class AddUserReferences < ActiveRecord::Migration
  def change
    add_reference :comments, :user, index: true
    add_reference :projects, :user, index: true
    add_reference :discussions, :user, index: true
    add_reference :tasks, :user, index: true
  end
end
