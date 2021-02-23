# PokeTraderCalculator
Ruby on Rails project that calculates fairness of pokemon trades between players

## How to Run - The Docker Way
---
The first step is to build docker containers. On the root directory of this project, run the command:
(You should not be running any local mongodb instances, or it will cause conflicts with the db container).
```
$ sudo docker-compose build
```

After, run this command to populate the database with pokemons.
(This may take some time.)
```
$ sudo docker-compose run poke_trader_calculator bash pokemon_import_script.sh
```

To run the tests:
```
$ sudo docker-compose run tests rspec
```

And then start the poke trader calculator service. The rails server will be available at `localhost:3000` 
```
$ sudo docker-compose up poke_trader_calculator
```


## How to Run - _Developer_ Way
---
Developed with Rails 6.0.3.5 and Ruby 2.7.2p137

Install Dependencies
```
$ bundle install
```
Set your mongodb instance the `mongoid.yml` file.
```
...
hosts:
    - localhost:27017 # Or whatever port you want to use.
```
and start your mongodb server with the console command
```
$ sudo mongod
```



A **REALLY IMPORTANT** step for appropriate usage is running the PokemonImportJob. This script uses the PokeApi to seed pokemon in our database. You could either run  `PokemonImportJob.perform_now` inside the interactive ruby bash **(irb)** or executing the sh script `pokemon_import_script`.

```
$ sh pokemon_import_script.sh
```

Now, we can start the server with
```
$ rails serve
```

### Running Tests:
```
$ rspec
```
---
