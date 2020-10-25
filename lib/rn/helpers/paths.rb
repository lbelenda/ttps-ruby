DEFAULT_DIR = "#{ENV["HOME"]}/.my_rns" # a preguntar si lo creo o no la primera vez
FileUtils.mkdir_p(DEFAULT_DIR)

def books_path(book)
  book ? "#{DEFAULT_DIR}/#{book}" : DEFAULT_DIR
end

def files_path(book, file)
  "#{books_path(book)}/#{file}"
end
