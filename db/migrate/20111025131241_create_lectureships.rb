class CreateLectureships < ActiveRecord::Migration
  def change
    create_table :lectureships do |t|
      t.belongs_to :booking
      t.belongs_to :teacher
    end

    add_index :lectureships, [:booking_id, :teacher_id], {unique: true}
  end
end
