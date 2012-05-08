#!/usr/bin/ruby

arg0 = File::basename(__FILE__)

require 'rubygems'
require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# A MySQL connection:
DataMapper.setup(:default, 'mysql://chembl:@localhost/chembl_13')

load "chembl_13.rb"
