module QuestionAndAnswerGroupingHelper
  def self.group(array, method)
    sort_group(array, method).group_by { |item| item.try(method) }
  end

  private

  def self.sort_group(array, method)
    objects = Array(array)

    all_objects(objects, method, objects_without_method(objects, method))
  end

  def self.objects_without_method(array, method)
    [].tap do |objects|
      array.each do |item|
        objects << item if item.try(method).nil?
      end
    end
  end

  def self.all_objects(objects, method, objects_without_method)
    objects_with_method = objects - objects_without_method

    objects_with_method.sort_by! { |item| item.try(method) }

    objects_with_method.reverse + objects_without_method
  end
end
