class MultiLogger<Logger

  def initialize(log_file_path)
    @loggers = [create_file_logger(log_file_path), create_stdout_logger]
  end

  def create_logger(source, level, format)
    logger = Logger.new(source)
    logger.level= level
    logger.formatter = format
    logger
  end

  def create_file_logger(log_file_path)
    log_file = File.open(log_file_path, 'a')
    format = Proc.new do |severity, datetime, progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
      "[#{date_format}] #{severity}: #{msg}\n"
    end
    create_logger(log_file, DEBUG, format)
  end

  def create_stdout_logger
    format = Proc.new { |severity, datetime, progname, msg| "#{msg}\n" }
    create_logger(STDOUT, INFO, format)
  end

  def add(severity, message = nil, progname = nil, &block)
    @loggers.each{ |logger| logger.add(severity, message, progname, &block) }
  end

end