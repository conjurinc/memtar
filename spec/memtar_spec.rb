require 'spec_helper'
require 'memtar'

describe MemTar do
  include SpecHelpers

  describe '#add_file' do
    it 'adds a file to the archive' do
      subject.add_file 'some-file', 'foo', mode: 0600, uname: 'nobody'
      has_file 'some-file', content: 'foo', mode: 0600, uname: 'nobody'
    end
  end
end
