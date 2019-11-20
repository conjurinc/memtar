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

    it 'correctly stores UTF-8 encoded strings' do
      subject.add_file 'utftest', 'na starość żółw wydziela wstrętną woń'
      has_file 'utftest', content: 'na starość żółw wydziela wstrętną woń'.b
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

    it 'handles content that is a factor of 512 bytes' do
      subject.add_file 'test_file', 'a' * 512
      subject.add_file 'another_test_file', 'some content'

      has_file 'another_test_file', content: 'some content'
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
