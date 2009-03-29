require 'active_record'
# connect to the database
ActiveRecord::Base.establish_connection({ :adapter => "sqlite3", :dbfile => "database.sqlite3" })
require 'digest/md5'
class Url < ActiveRecord::Base
  before_save :make_code
  protected
  def make_code
    if !self.code
      code = rand_code
      fake = Url.find_by_code( code )
      while !fake.nil?
        code = rand_code
        fake = Url.find_by_code( url.code )
      end
      self.code = code
    end
  end
  def rand_code
    bound = 1 + rand(5)
    return Digest::MD5.hexdigest( url )[1..bound]
  end
end
