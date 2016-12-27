# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pug/worker/version'

Gem::Specification.new do |spec|
  spec.name          = 'pug-worker'
  spec.version       = Pug::Worker::VERSION
  spec.authors       = 'Pug CI Team'

  spec.summary       = 'Pug building apps'
  spec.description   = 'Pug building apps'
  spec.homepage      = 'https://github.com/pug-ci/pug-worker'
  spec.license       = 'MIT'
end
