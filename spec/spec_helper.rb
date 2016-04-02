$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sjs'
require 'lock_jar'
LockJar.load

java.lang.System.setProperty(org.slf4j.impl.SimpleLogger::DEFAULT_LOG_LEVEL_KEY, "TRACE");
