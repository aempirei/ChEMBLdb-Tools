#!/bin/bash

perl -pe 's=/\*.*?\*/\s*==g' \
| perl -pe 's/--.*$//' \
| pcregrep -v '^\s*;\s*$' \
| pcregrep '\S' \
| perl -pe "s/CREATE TABLE \`(\w+)\` \(/class \$1\n\tinclude DataMapper::Resource\n\tstorage_names[:default] = '\$1'/" \
| perl -pe 's/^.*\) ENGINE.*/end\n/' \
| perl -pe 's/^\s*`(\w+)`\s*(.*)/\t@{[sprintf("%-40s","property :$1")]} # $2/' \
| perl -pe 's/C\w+T\s+`\w+`\s+F\w+N KEY\s+\(`(\w+)`\)\s+R\w+S\s+`(\w+)`\s+\(`(\w+)`\).*/\tbelongs_to :\2, :child_key => [ :\1 ], :parent_key => [ :\3 ]/' \
| perl -pe 's/((\w+\s*)?KEY)/\t# \1/' \
| perl -pe 's*class\s+(\w+)*class @{[join("", map { $_ = ucfirst($_) } split(/_/, $1))]}*' \

