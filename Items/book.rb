require_relative './item'
require_relative '../properties/label'

class Book < Item
  attr_accessor :publisher, :cover_state, :label, :archived

  def initialize(publish_date, publisher, cover_state, label)
    super(publish_date, archived)
    @publisher = publisher
    @cover_state = cover_state
    @label = label
    @archived = false
  end

  def add_label(label)
    label.books.push(self) unless label.books.include?(self)
  end

  def self.list_all_books(books)
    if books.empty?
      puts 'No Book added yet'
    else
      books.each_with_index do |book, index|
        puts "#{index + 1} ) Published: #{book.publisher}  Cover State: #{book.cover_state}  Publish Date: #{book.publish_date}\n\n  "
      end
    end
  end

  def self.create_book(labels)
    print 'Enter the book publisher: '
    publisher = gets.chomp
    print "Enter the book cover state ['good' or 'bad']: "
    cover_state = gets.chomp
    cover_state = cover_state.downcase
    print 'Enter Publish date in the following format [dd/mm/y]: '
    date = gets.chomp
    date = valid_date?(date) ? date : valid_date?(date)
    while date == false
      puts "\n\nPlease enter a valid date according to the format.".colorize(color: :yellow).bold
      puts "\n\nEnter release date in the following format [dd/mm/yyyy]: "
      date = gets.chomp
    end
    print 'Enter the label title: '
    title = gets.chomp
    print 'Enter the label color: '
    color = gets.chomp
    label = Label.new(title, color)
    labels << label
    new(date, publisher, cover_state, label)
  end

  def self.valid_date?(date)
    date_format = '%d/%m/%Y'
    DateTime.strptime(date, date_format)
    true
  rescue ArgumentError
    false
  end

  private

  def can_be_archived?
    @archived = super || @cover_state == 'bad'
  end
end
