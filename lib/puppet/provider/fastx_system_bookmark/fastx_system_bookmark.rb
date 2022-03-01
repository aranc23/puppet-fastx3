# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'

# Implementation for the fastx_system_bookmark type using the Resource API.
class Puppet::Provider::FastxSystemBookmark::FastxSystemBookmark < Puppet::ResourceApi::SimpleProvider
  def initialize
    # read /usr/lib/fastx/3/.env
    # and look for FX_LOCAL_DIR in there or in the current environment
    # then read all the entries from FX_LOCAL_DIR/store/system-bookmark-store.db
    @store = '/var/fastx/local/store/system-bookmark-store.db'
    super()
  end
  def get(context)
    context.debug('Returning pre-canned example data XXX')
    bookmarks = {}
    context.debug("Using #{@store} for system bookmark database.")
    File.readlines(@store).each do |ln|
      p = JSON.parse(ln)
      if p.key?('$$deleted') and p['$$deleted'] == true
        if bookmarks.key?(p['_id'])
          bookmarks.delete(p['_id'])
        end
        next
      end
      bookmarks[p['_id']] = p
    end
    context.debug(bookmarks)
    # convert to a list
    list = []
    bookmarks.each do |i,d|
      list << { :name => i, :data => d['data'], :ensure => 'present' }
    end
    return list
  end

  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
    #context.notice(name)
    #context.notice(should.inspect)

    hash = { '_id' => name, 'data' => should[:data] }
    context.debug(hash)
    json = JSON.generate(hash)
    open(@store, 'a') do |f|
      context.debug("about to write #{json}")
      f.puts json
    end
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    hash = { '_id' => name, 'data' => should[:data] }
    context.debug(hash)
    json = JSON.generate(hash)
    open(@store, 'a') do |f|
      context.debug("about to write #{json}")
      f.puts json
    end
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    json = JSON.generate({ "_id" => name, "$$deleted" => true })
    open(@store, 'a') do |f|
      context.debug("about to write #{json}")
      f.puts json
    end
  end
end
