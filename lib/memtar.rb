# frozen_string_literal: true

require 'archive/tar/minitar'
require 'memtar/version'

# In-memory tar archive writer.
class MemTar
  def initialize
    @io = StringIO.new
  end

  def add_file path, content, opts = {}
    return add_existing_file path, content if content.is_a?(File) && opts.empty?
    fail ArgumentError, "handling of paths over 100 bytes long not implemented" if path.size > 100

    size = content.bytesize
    @io.write header opts.merge size: size, name: path
    @io.write content
    @io.write "\0" * (512 - size % 512)
  end

  def add_symlink path, target
    fail ArgumentError, "handling of paths over 100 bytes long not implemented" if path.size > 100
    @io.write header typeflag: '2', size: 0, mode: 0777, name: path, linkname: target
  end

  def add_existing_file path, file
    stat = file.lstat
    if stat.symlink?
      add_symlink path, File.readlink(file.path)
    else
      add_file path, file.read, MemTar.opts_of_stat(stat)
    end
  end

  def self.opts_of_stat stat
    uid, gid = [stat.uid, stat.gid]
    {
      mode: stat.mode & 0777,
      uid: uid, gid: gid,
      uname: Etc.getpwuid(uid).name,
      gname: Etc.getgrgid(gid).name,
      mtime: stat.mtime
    }
  end

  def to_s
    @io.string + "\0" * 1024
  end

  def header opts
    Archive::Tar::Minitar::PosixHeader.new(default.merge(opts)).to_s
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
