class Book
  attr_accessor :name, :global

  def self.create(name)
    unless name.nil?
      if valid_name? name
        if Dir.exist?(books_path(name))
          puts "the book '#{name}' already exists, your note will be saved there"
        else
          puts "creating book"
          TTY::File.create_dir(books_path(name))
          puts "book '#{name}' created succesfully"
        end
      else
        puts "Only numbers, letters and spaces are allowed for the book title"
        abort
      end
    end
  end

  def self.rename(old_name, new_name)
    if File.exist? books_path(old_name)
      if !File.exist? books_path(new_name)
        File.rename(books_path(old_name), books_path(new_name))
        puts "Book '#{old_name}' renamed to: '#{new_name}' succesfully."
      else
        puts "Error: Book with name '#{new_name}' already exists, please choose another"
      end
    else
      puts "Error: Book '#{old_name}' does not exist."
    end
  end

  def self.delete_global_book
    puts "Are you sure you want to delete ALL the notes from global book? [y/n]"
    choice = $stdin.gets.chomp
    case choice
    when "y"
      if get_notes_from_path(books_path).any?
        get_notes_from_path(books_path).each { |note| File.delete(note) }
        puts "ALL notes from global book were deleted succesfully"
      else
        puts "Global book is empty"
      end
    when "n"
      puts "Deletion of ALL notes from global book cancelled"
    else
      puts "Wrong option."
    end
  end

  def self.delete_book(name)
    if Dir.exist?(books_path(name))
      puts("Are you sure you want to delete the book '#{name}'? [y/n]")
      choice = $stdin.gets.chomp
      case choice
      when "y"
        FileUtils.rm_rf(books_path(name)); puts "Book '#{name}' deleted succesfully"
      when "n"
        puts "Deletion of '#{name}' cancelled"
      else
        puts "Wrong option."
      end
    else
      puts "Book '#{name}' does not exist"
    end
  end

end