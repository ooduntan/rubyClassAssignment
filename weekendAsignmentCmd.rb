class NotesApplication
	def initialize(author)
		@author=author
		@author_notes=Hash.new()
	end
	def create(note_content)
		if note_content.length>0
			@author_notes[(@author_notes.length+1)]=note_content
			return "You have created a note"
		else
			return "Oops! It seems your note is empty."
		end
	end
	def list()
		returnValue=""
		if @author_notes.length> 0
			@author_notes.each{|id, note| returnValue<< "Note ID: #{id}\n#{note}\n\nBy Author #{@author}\n\n" }
		else
			returnValue="Oops! this list is empty"
		end
		return returnValue
	end
	def get(note_id)
		if @author_notes[note_id].is_a?(NilClass)==false
			return @author_notes[note_id]
		else
			return "Oops! #{note_id} does not exist"
		end
	end
	def search(search_text)
		returningHash=Hash.new()
		if search_text.length<=0
			return "You have to look for something"
		else
			@author_notes.each do |note_id , note|
				if note.downcase.include? search_text.downcase
					returningHash[note_id]=note
				end
			end
			if returningHash.length<=0
				return "No result found for search #{search_text}"
			else
				search_result="Showing #{returningHash.length} results for search '#{search_text}'  "
				returningHash.each{|n_id, n| search_result<< "Note ID: #{n_id} #{n}  By Author #{@author}  "}
				return search_result
			end
		end
	end
	def delete(note_id)
		if @author_notes.delete(note_id).is_a?(NilClass)
			return "#{note_id} doesn't exist"
		else
			@author_notes.delete(note_id)
			return "#{note_id} was deleted"
		end
	end
	def edit(note_id, new_content)
		if @author_notes.has_key?(note_id)== true && new_content.length>0
			@author_notes[note_id]=new_content
			return "You have successfully edited #{note_id}"
		else
			return "Oops! its seems your note ID is wrong or your new content is empty"
		end
	end

end

def menu()
	puts "What do you want to do? Press 1 to create a note, 2 to list all notes, 3 to get a note, 4 to search for a note, 5 to delete a note, 6 to edit a note"
	choosenMenu=gets.chomp
	return choosenMenu
end

def nav(noteApp)
		chosMen=menu()
	if chosMen.strip=="1"
		puts "Type the new note here"
		newNote=gets.chomp
		puts noteApp.create(newNote)
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	elsif chosMen.strip=="2"
		puts noteApp.list()
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	elsif chosMen.strip=="3"
		puts "Type ID of the note here"
		newNote=gets.chomp
		puts noteApp.get(newNote.to_i)
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	elsif chosMen.strip=="4"
		puts "What are you looking for?"
		newNote=gets.chomp
		puts noteApp.search(newNote)
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	elsif chosMen.strip=="5"
		puts "Type ID of the note you want to delete here"
		newNote=gets.chomp
		puts noteApp.delete(newNote.to_i)
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	elsif chosMen.strip=="6"
		puts "Type ID of the note you want to edit here"
		newNote=gets.chomp
		puts "Type the note  here"
		newNotex=gets.chomp
		puts noteApp.edit(newNote.to_i,newNotex)
		puts "Press Enter to continue"
		newNote=gets.chomp
		nav(noteApp)
	else
		puts "Invalid selection try again"
		nav(noteApp)
	end

end
	puts "Hello! Good day please enter your name"
	name=gets.chomp
	puts "Hello "+ name+" how do you do?"
	noteApp=NotesApplication.new(name)
	nav(noteApp)
