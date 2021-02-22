#/bin/bash

# Maybe need to prefix with `bundle exec`
rails runner 'bundle exec PokemonImportJob.perform_now'
