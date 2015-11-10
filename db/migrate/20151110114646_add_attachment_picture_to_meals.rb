class AddAttachmentPictureToMeals < ActiveRecord::Migration
  def self.up
    change_table :meals do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :meals, :picture
  end
end
