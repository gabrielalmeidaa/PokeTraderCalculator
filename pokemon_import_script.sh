#/bin/bash

# Maybe need to prefix with `bundle exec`
rails runner 'PokemonImportJob.perform_now'
