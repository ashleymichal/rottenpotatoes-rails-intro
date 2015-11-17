class Movie < ActiveRecord::Base
  @@all_ratings = { 'G'     => true,
                    'PG'    => true,
                    'PG-13' => true,
                    'R'     => true,
                    'NC-17' => true }
  def self.all_ratings
    @@all_ratings
  end
  
  def self.all_ratings= ratings_hash
    @@all_ratings.keys.each do |rating|
      @@all_ratings[rating] = ratings_hash.include?(rating)
    end
  end
end
