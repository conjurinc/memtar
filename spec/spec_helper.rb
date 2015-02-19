module SpecHelpers
  def reader
    @reader ||= Archive::Tar::Minitar::Reader.new StringIO.new subject.to_s
  end

  module TarEntryWithContent
    attr_reader :content

    def self.extended entry
      entry.read
    end

    def read
      @content ||= super
    end
  end

  # Disregard spurious :reek:ControlParameter
  def seek path
    reader.rewind
    reader.each do |entry|
      return entry.extend TarEntryWithContent if entry.full_name == path
    end
  end

  def has_file path, opts
    file = seek path

    expect(file).to be

    opts.each do |key, value|
      expect(file.send key).to eq value
    end

    file
  end

  def has_symlink path
    file = seek path

    expect(file).to be
    expect(file.typeflag).to eq '2'

    # linkname reading is broken in minitar
    # expect(file.linkname).to eq target

    file
  end
end
