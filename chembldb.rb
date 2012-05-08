#!/usr/bin/ruby

arg0 = File::basename(__FILE__)

def usage(prog)
	print "
usage: #{prog} [options]

perform various queries against ChEMBLdb (chembl_13)

     -h, --help     show help
     -c, --chembl   lookup a compound by CHEMBL#
     -v, --verbose  display additional information

"

	exit
end

require 'rubygems'
require 'mysql'
require 'getoptlong'

$c = {
    :hostname  => 'localhost',
    :username  => 'chembl',
    :password  => '',
    :dbname    => 'chembl_13',
    :verbose   => false,
	 :chembl_id => nil,
}

$my = Mysql.new($c[:hostname], $c[:username], $c[:password], $c[:dbname])

opts = GetoptLong.new(
    [ '--help'   , '-h', GetoptLong::NO_ARGUMENT       ],
    [ '--chembl' , '-c', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--verbose', '-v', GetoptLong::NO_ARGUMENT       ],
)

opts.each do |opt,arg|
	case opt
		when '--help'
			usage arg0
		when '--verbose'
			$c[:verbose] = true
		when '--chembl'
			$c[:chembl_id] = arg
	end
end

def chembl_query(chembl_id)
	chembl_id = "CHEMBL#{chembl_id}" if(chembl_id =~ /^\d+$/)
	return "select * from molecule_dictionary as md where chembl_id = '#{chembl_id}' limit 1"
end

def display_information(chembl_id)

	st = $my.query chembl_query $c[:chembl_id]

	if st
		fields = st.fetch_fields

		row = st.fetch_hash

		fields.each do |f|
			value = row[f.name]
			if(value.nil?)
				value = 'NULL'
			elsif(f.is_num?)
				#
			else
				value = "\"#{value}\""
			end
			puts "#{f.name} => #{value}"
		end
	end

end

if not $c[:chembl_id].nil?

	display_information $c[:chembl_id]

else

	usage arg0

end

