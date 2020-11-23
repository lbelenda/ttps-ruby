class Note
  attr_accessor :title, :book

  require "tempfile"

  def self.create(title, book)

    require_relative "../classes/book"

    if valid_name? title
      if !book.nil?
        if valid_name?(book)
          Book.create(book)
        else
          return puts "Only numbers, letters and spaces are allowed for the book title"
        end
      end
      tmp = Tempfile.new("buffer")
      tmp.rewind
      TTY::Editor.open(tmp.path, command: default_editor)
      if tmp.size > 0
        title += ".rn"
        TTY::File.copy_file tmp.path, files_path(book, title)
      else
        puts "You cannot create an empty note."
      end
    else
      puts "Only numbers, letters and spaces are allowed for the note title"
    end
  end

  def self.edit(title, book)
    if File.exist? files_path(book, title)
      TTY::Editor.open(files_path(book, title), command: default_editor)
      puts "File '#{title}' updated succesfully."
    else
      puts "Error: File #{title} does not exist."
    end
  end

  def self.retitle(old_title, new_title, book)
    if File.exist? files_path(book, old_title)
      if File.exist? files_path(book, new_title)
        puts "Error: File #{new_title} already exists, please try with another name"
      else
        File.rename(files_path(book, old_title), files_path(book, new_title))
        puts "Renamed file #{old_title} to #{new_title}"
      end
    else
      puts "Error: File #{old_title} does not exist."
    end
  end

  def self.show(title, book)
    File.foreach(files_path(book, title)) { |line| puts line }
  end

  def self.delete(title, book)
    if File.exist? files_path(book, title)
      TTY::File.remove_file files_path(book, title)
      puts "File '#{title}' removed succesfully."
    else
      puts "Error: File '#{title}' does not exist."
    end
  end

  def self.export_html(title, book)
    require "redcarpet"
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    note_title = title + ".rn"
    exported_note_title = title + ".html"
    if File.exist? files_path(book, note_title)
      text = File.read(files_path(book, note_title))
      tmp = markdown.render(text)
      TTY::File.create_file files_path(book, exported_note_title), tmp
    else
      puts "Note '#{note_title}' does not exist"
    end
  end

end