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

      # Написать свою функцию my_map
      def my_map(&blk)
        iterate = lambda do |acc, collection, &block|
          return acc if collection.empty?

          first, *rest = collection
          processed_item = yield first
          new_acc = [*acc, processed_item]

          iterate.call(new_acc, rest, &block)
        end

        mapped_collection = iterate.call([], self, &blk)

        MyArray.new(mapped_collection)
      end

      # Написать свою функцию my_compact
      def my_compact
        iterate = lambda do |acc, collection|
          return acc if collection.empty?

          first, *rest = collection
          return iterate.call(acc, rest) if first.nil?

          new_acc = [*acc, first]
          iterate.call(new_acc, rest)
        end

        compacted_collection = iterate.call([], self)

        MyArray.new(compacted_collection)
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
    end
  end
end
