express = require 'express'
bodyParser = require 'body-parser'

app = express()

app.use(bodyParser.json())

app.post '/docker/hub/webhook', (req, res) =>
  res.send JSON.stringify(req.body, null, 2)

app.listen process.env.PORT || 8080 , =>
  console.log "Example app listening on port #{ process.env.PORT || 8080 }!"