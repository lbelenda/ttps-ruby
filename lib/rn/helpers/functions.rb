def get_books_from_path(books_path)
  Dir.chdir(books_path)
  Dir.glob("*").select { |filename| File.directory? filename }
end

def get_notes_from_path(books_path)
  Dir.chdir(books_path)
  Dir.glob("*").reject { |filename| (File.directory?(filename) || filename.include?(".html")) }
end

def default_editor
  ENV["EDITOR"].split("/")[-1]
end

def valid_name?(name)
  /^[a-zA-Z\d\s]*$/.match?(name)
end
