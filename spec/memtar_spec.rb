require 'spec_helper'

require 'tempfile'

require 'memtar'

describe MemTar do
  include SpecHelpers

  describe '#add_file' do
    it 'adds a file to the archive' do
      subject.add_file 'some-file', 'foo', mode: 0600, uname: 'nobody'
      has_file 'some-file', content: 'foo', mode: 0600, uname: 'nobody'
    end

    it 'handles File arguments' do
      file = Tempfile.new 'foo'
      file.chmod 0750
      file.write 'bar'
      file.close

      subject.add_file 'xyzzy', File.new(file.path)
      has_file 'xyzzy', content: 'bar', mode: 0750, uname: Etc.getlogin
      file.unlink
    end

    it 'handles symlinks as File arguments' do
      file = Tempfile.new 'foo'
      path = file.path
      file.close
      file.unlink

      FileUtils.ln_s '/etc/passwd', path

      subject.add_file 'xyzzy', File.new(path)
      has_symlink 'xyzzy'
      File.unlink path
    end
  end

  describe '#add_symlink' do
    it 'creates a symlink in the archive' do
      subject.add_symlink 'password-file', '/etc/passwd'
      has_symlink 'password-file'
    end
  end
end
