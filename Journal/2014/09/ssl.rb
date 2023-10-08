# config/ssl.yml
host: <host>
pass: <pass>

# config/initializers/ssl.rb
class SSLConfig
  class << self
    attr_accessor :host, :pass
  end
end

config = YAML.load(IO.read(Rails.root.join('config', 'database.yml')))
SSLConfig.host = config['host']
SSLConfig.pass = config['pass']

# lib/ssl/timestamps.rb
class SSL
  def create_timestamp(file, host, pass)
    # ...
  end
end

# app/services/timestamp_file.rb
require 'ssl/timestamps'

class TimestampFile
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    SSL.create_timestamp(file, SSLConfig.host, SSLConfig.pass)
  end
end

# app/models/document.rb
class Document
  # attribut file

  before_save do
    self.timestamp = TimestampFile.new(file).run
    # ...
  end
end
