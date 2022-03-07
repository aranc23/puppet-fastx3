# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'

# Implementation for the fastx_system_bookmark type using the Resource API.
class Puppet::Provider::FastxSystemBookmark::FastxSystemBookmark < Puppet::ResourceApi::SimpleProvider
  # @summary opens and reads the system-bookmark-store.db
  def initialize
    # the .../install/suggestions script uses the following logic to
    # find key directories: (converted from perl to ruby)
    @fx_var_dir = ENV.key?('FX_VAR_DIR') ? ENV['FX_VAR_DIR'] : '/var/fastx'
    @fx_local_dir = ENV.key?('FX_LOCAL_DIR') ? ENV['FX_LOCAL_DIR'] : File.join(@fx_var_dir,'local');
    @fx_config_dir = ENV.key?('FX_CONFIG_DIR') ? ENV['FX_CONFIG_DIR'] : '/etc/fastx'
    @bookmark_db = File.join(@fx_local_dir,'store','system-bookmark-store.db')

    @bookmarks = {}
    File.readlines(@bookmark_db).each do |ln|
      p = JSON.parse(ln)
      if p.key?('$$deleted') and p['$$deleted'] == true
        # if this entry is marked as deleted
        if @bookmarks.key?(p['_id'])
          @bookmarks.delete(p['_id'])
          # delete it from the @bookmarks hash
        end
        # skip to the next bookmark without adding it
        next
      end
      # create a hash using the _id key as the new hash key
      @bookmarks[p['_id']] = p
    end
    # convert to a list to return
    super()
  end
  def write_hash_to_db_as_json(hash)
    # append to database file
    open(@bookmark_db, 'a') do |f|
      f.puts JSON.generate(hash)
    end
  end
  def get(context)
    # convert to a list to return
    list = []
    @bookmarks.each do |i,d|
      list << { :name => i, :data => d['data'], :ensure => 'present' }
    end
    return list
  end
  
  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
    hash = { '_id' => name, 'data' => should[:data] }
    write_hash_to_db_as_json(hash)
  end
  
  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    write_hash_to_db_as_json( { '_id' => name, 'data' => should[:data] } )
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    write_hash_to_db_as_json({ '_id' => name, '$$deleted' => true })
  end
end
