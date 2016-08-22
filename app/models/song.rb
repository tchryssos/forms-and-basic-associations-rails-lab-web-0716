class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
    self.save
  end

  def genre_name
    if self.genre
      self.genre.name
    end
  end

  def artist_name=(name)
    self.artist=Artist.find_or_create_by(name:name)
    self.save
    self.artist.save
  end

  def artist_name
    if self.artist
      self.artist.name
    end
  end

  def note_contents=(contents)
    if contents != ""
      if contents.is_a?(String)
        note=Note.create(content:contents)
        self.notes<<note
      else
        contents.each do |content|
          note=Note.create(content:content)
          self.notes<<note
        end
      end
    end
  end

  def note_contents
    if self.notes
      notes=self.notes.collect do |note|
        unless note.content==""
          note.content
        end
      end
    end
    notes.compact
  end

end
