module Exercise
  module Arrays
    class << self
      def replace(array)
        max_number = array.reduce { |acc, number| number > acc ? number : acc }
        array.map { |number| number.negative? ? number : max_number }
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
