require 'archive/tar/minitar'
require 'memtar/version'

# In-memory tar archive writer.
class MemTar
  def initialize
    @io = StringIO.new
  end

  def add_file path, content, opts = {}
    fail ArgumentError, "handling of paths over 100 bytes long not implemented" if path.size > 100
    size = content.size
    @io.write header opts.merge size: size, name: path
    @io.write content
    @io.write "\0" * (512 - size % 512)
  end

  def to_s
    @io.string + "\0" * 1024
  end

  def header opts
    Archive::Tar::PosixHeader.new(default.merge opts).to_s
  end

  def default
    @default ||= {
      mode: 0644,
      uid: 0, gid: 0,
      uname: 'wheel', gname: 'wheel',
      mtime: Time.now,
      prefix: ''
    }
  end
end
