module Exercise
  module Fp2
    class MyArray < Array
      # Использовать стандартные функции массива для решения задач нельзя.
      # Использовать свои написанные функции для реализации следующих - можно.

      # Написать свою функцию my_each

      def my_each(&blk)
        iterate = lambda do |array, &block|
          return nil if array.empty?

          first, *rest = array
          yield first

          iterate.call(rest, &block)
        end

        iterate.call(self, &blk)

        self
      end

      # Написать свою функцию my_reduce
      def my_reduce(initial_value = nil, &blk)
        iterate = lambda do |acc, collection, &block|
          return acc if collection.empty?

          if acc.nil?
            first, second, *rest = collection
            processed_item = yield first, second
          else
            first, *rest = collection
            processed_item = yield acc, first
          end
          iterate.call(processed_item, rest, &block)
        end

        if initial_value.nil?
          iterate.call(nil, self, &blk)
        else
          iterate.call(initial_value, self, &blk)
        end
      end

      # Написать свою функцию my_map
      def my_map
        inner_block = lambda do |acc, el|
          processed_item = yield el
          [*acc, processed_item]
        end
        MyArray.new(my_reduce([], &inner_block))
      end

      # Написать свою функцию my_compact
      def my_compact
        reduce_nil = lambda do |acc, el|
          return acc if el.nil?

          [*acc, el]
        end
        MyArray.new(my_reduce([], &reduce_nil))
      end
    end
  end
end
