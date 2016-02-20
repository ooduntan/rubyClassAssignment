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
			@author_notes.each{|id, note| returnValue<< "Note ID: #{id} \n#{note} \n\nBy Author #{@author}\n\n" }
		else
			returnValue="Oops! this list is empty"
		end
		return returnValue
	end
	def get(note_id)
		if @author_notes[note_id].is_a(NilClass)==false
			return @author_notes[note_id]
		else
			return "Oops! #{note_id} is an does not exist"
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
			if returnValue.length<=0
				return "No result found for search #{search_text}"
			else
				search_result="Showing #{returnValue.length} results for search #{search_text} \n\n"
				returningHash.each{|n_id, n| search_result<< "Note ID: #{n_id}\n#{n}\n\n By Author #{@author}\n\n"}

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
	def edit(note_id)

	end

end