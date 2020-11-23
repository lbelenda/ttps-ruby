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

        require_relative "../classes/note"

        def call(title:, **options)
          book = options[:book]
          title += ".rn"
          Note.create(title, book)
        rescue Errno::EACCES
          puts "Permission denied for create '#{title}' on '#{books_path(book)}'"
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
          title += ".rn"
          Note.delete(title, book)
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
          title += ".rn"
          Note.edit(title, book)
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
          old_title += ".rn"
          new_title += ".rn"
          Note.retitle(old_title, new_title, book)
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
            filenames = get_notes_from_path(books_path(book))
            directories = get_books_from_path(books_path(book))
            directories.each do |directory|
              filenames.push(get_notes_from_path(books_path(directory))) unless Dir.empty?(books_path(directory))
            end
            puts "All notes:\n - #{filenames.join("\n - ")}"
          elsif book.nil? && global
            filenames = get_notes_from_path(books_path)
            puts "Global notes:\n #{filenames.join("\n - ")}"
          elsif book
            filenames = get_notes_from_path(books_path(book))
            puts "#{book} notes:\n#{filenames.join("\n - ")}"
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
          title += ".rn"
          if File.exist? files_path(book, title)
            Note.show(title, book)
          else
            puts "Error: file '#{title}' does not exist"
          end
        end
      end
    end
  end
end
