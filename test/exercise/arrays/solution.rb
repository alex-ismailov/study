module Exercise
  module Arrays
    class << self
      def replace(array)
        new_array = []
        get_max = lambda { |collection|
          max_num = 0
          collection.each do |number|
            max_num = number if number > max_num
          end
          max_num
        }

        max_num = get_max.call(array)
        array.each do |number|
          new_array << if number >= 0
                         max_num
                       else
                         number
                       end
        end

        new_array
      end

      def search(array, query)
        iterate = lambda { |first_index, last_index|
          return -1 if first_index > last_index

          middle_index = first_index + last_index
          return middle_index if query == array[middle_index]

          return iterate.call(middle_index + 1, last_index) if query > array[middle_index]

          iterate.call(first_index, middle_index - 1)
        }

        iterate.call(0, array.length - 1)
      end
    end
  end
end
