class SumValidator < ActiveModel::Validator



  def validate(record)
    sum = 0
    record.story.tasks.each do |task|
      sum += task.weight
    end
    if sum > 100
      record.errors[:base] = "Sum of task weights for this Story cannot exceed 100%"
    end
  end

end
