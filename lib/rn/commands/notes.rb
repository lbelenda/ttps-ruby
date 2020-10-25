module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc "Create a note"

        argument :title, required: true, desc: "Title of the note"
        option :book, type: :string, desc: "Book"

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          Books::Create.new.call name: book unless book.nil?
          if !File.exist? files_path(book, title)
            puts "Stop writing the note with CTRL + D"
            file = File.open(files_path(book, title), "w")
            text = STDIN.read
            file.write text
            puts "note created succesfully"
          else
            puts "the note already exist, maybe you want to edit it?"
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc "Delete a note"

        argument :title, required: true, desc: "Title of the note"
        option :book, type: :string, desc: "Book"

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          if File.exist? files_path(book, title)
            File.delete files_path(book, title)
            puts "File '#{title}' removed succesfully."
          else
            puts "Error: File '#{title}' does not exist."
          end
          # warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc "Edit the content a note"

        argument :title, required: true, desc: "Title of the note"
        option :book, type: :string, desc: "Book"

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Retitle < Dry::CLI::Command
        desc "Retitle a note"

        argument :old_title, required: true, desc: "Current title of the note"
        argument :new_title, required: true, desc: "New title for the note"
        option :book, type: :string, desc: "Book"

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          book = options[:book]
          if File.exist? files_path(book, old_title)
            File.rename(files_path(book, old_title), files_path(book, new_title))
          else
            puts "Error: File #{old_title} does not exist."
          end
          # warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc "List notes"

        option :book, type: :string, desc: "Book"
        option :global, type: :boolean, default: false, desc: "List only notes from the global book"

        example [
          "                 # Lists notes from all books (including the global book)",
          "--global         # Lists notes from the global book",
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          if book.nil? && !global
            Dir.chdir(books_path(nil))
            filenames = Dir.glob("*").reject { |filename| File.directory? filename }
            directories = Dir.glob("*").select { |filename| File.directory? filename }
            directories.each do |directory|
              Dir.chdir(books_path(directory))
              filenames.push(Dir.glob("*").reject { |filename| File.directory? filename })
            end
            puts "All notes:\n #{filenames.join("\n")}"
          elsif book.nil? && global
            Dir.chdir(books_path(nil))
            filenames = Dir.glob("*").select { |filename| File.file? filename }
            puts "Global notes:\n #{filenames.join("\n")}"
          elsif book
            Dir.chdir(books_path(book))
            filenames = Dir.glob("*").select { |filename| File.file? filename }
            puts "#{book} notes:\n#{filenames.join("\n")}"
          end
        end
      end

      class Show < Dry::CLI::Command
        desc "Show a note"

        argument :title, required: true, desc: "Title of the note"
        option :book, type: :string, desc: "Book"

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
