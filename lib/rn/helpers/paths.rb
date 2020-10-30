DEFAULT_DIR = "#{ENV["HOME"]}/.my_rns" # a preguntar si lo creo o no la primera vez
FileUtils.mkdir_p(DEFAULT_DIR)

def books_path(book)
  book.nil? ? DEFAULT_DIR : "#{DEFAULT_DIR}/#{book}"
end

def files_path(book, file)
  "#{books_path(book)}/#{file}"
end
