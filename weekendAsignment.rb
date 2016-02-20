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


require "rspec"

RSpec.describe "NotesApplication" do

	subject = NotesApplication.new("Stephen")
  it "Oops! It seems your note is empty." do
    matches = subject.create("")

    expect(matches).to eq "Oops! It seems your note is empty."
  end

  it "Empty list" do
    matches = subject.list()
    expect(matches).to eq "Oops! this list is empty"
  end

  it "Invalid note_id" do
    matches = subject.get("eagle")
    expect(matches).to eq "Oops! eagle does not exist"
  end

  it "creates a note" do
    matches = subject.create("this is my first note")
    expect(matches).to eq "You have created a note"
  end

  it "list all the note" do
    matches = subject.list()
    expect(matches).to eq "Note ID: 1\nthis is my first note\n\nBy Author Stephen\n\n"
  end

  it "detects invalid key" do
    matches = subject.get(0)
    expect(matches).to eq "Oops! 0 does not exist"
  end

  it "detects Invalid note id" do
    matches = subject.edit('gallery', 'ballerina');
    expect(matches).to eq "Oops! its seems your note ID is wrong or your new content is empty"
  end

  it "delete Note" do
    matches = subject.delete(1)
    expect(matches).to eq "1 was deleted"
  end

  it "Should create a note" do
    matches = subject.create('I love so much Banana')
    expect(matches).to eq "You have created a note"
  end

  it "Should create a note" do
    matches = subject.create("this is the second note i am creating in 2 minutes")
    expect(matches).to eq "You have created a note"
  end

  it "Should return one result" do
    matches = subject.search("2 minutes")
    expect(matches).to eq "Showing 1 results for search '2 minutes'  Note ID: 2 this is the second note i am creating in 2 minutes  By Author Stephen  "
  end
end