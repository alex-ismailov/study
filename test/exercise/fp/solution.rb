module Exercise
  module Fp
    class << self
      def rating(array)
        compacted_films = array.select { |film| !film['country'].blank? }       
        filtered_films = compacted_films.select do |film|
          film['rating_kinopoisk'].to_f > 0 && film['country'].split(',').length >= 2
        end
        sum = filtered_films.reduce(0.0) { |acc, film| acc + film['rating_kinopoisk'].to_f }
        
        sum / filtered_films.length
      end

      def chars_count(films, threshold)
        selected_films = films.select { |film| film['rating_kinopoisk'].to_f >= threshold }

        selected_films.reduce(0) do |acc, film|
          acc + (film['name'].chars.select { |char| char == 'и' }).count
        end
      end
    end
  end
end
